extends CharacterBody3D

@export_group("movement")
@export var speed = 1.5
@export var fall_acceleration = 15
@export var jump_impulse = 5
@export var collision_force = 150

@export_group("camera")
@export var x_invert = true
@export var x_sensitivity = 1.0
@export var y_invert = false
@export var y_sensitivity = 1.0
@export var high_angle = 60
@export var low_angle = 60

@export_group("growth")
@export_flags_3d_physics var knockback_during_grow = 0
@export var shrink_curve: Curve
@export var speed_size_curve: Curve
@export var shrink_rate = 0.3
var target_velocity = Vector3.ZERO;

var size_key = 0.5
var size_factor = 1.0
var collider_height = 0.0
var collider_radius = 0.0
var arm_distance = 0.0
var vacuum_offset = Vector3.ZERO
var camera_offset = Vector3.ZERO
var growing = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	collider_height = $Collider.shape.height
	collider_radius = $Collider.shape.radius
	arm_distance = $CameraPivot/CameraArm.spring_length
	vacuum_offset = $CameraPivot/Vacuum.position
	camera_offset = $CameraPivot/CameraArm/CameraOffset/Camera.position

func _can_grow():
	return not is_on_ceiling() or not is_on_floor()


func _process_shrink(delta):
	var space_state = get_world_3d().direct_space_state
	if Input.is_action_pressed("shrink"):
		size_key = clamp (size_key - shrink_rate * delta * 0.5, 0.0, 1.0)
		growing = false
	elif Input.is_action_pressed("grow") and _can_grow():
		var query = PhysicsRayQueryParameters3D.create(
				global_position, 
				$Mesh/HeadRaycastTarget.global_position, 
				knockback_during_grow)
		var result = space_state.intersect_ray(query)
		if result:
			result.collider.apply_impulse(Vector3.UP * collision_force, result.position)
		size_key = clamp (size_key + shrink_rate * delta * 0.5, 0.0, 1.0)
		growing = true
	else:
		growing = false
		return
		
	size_factor = shrink_curve.sample(size_key)
	$Collider.shape.height = collider_height * size_factor
	$Collider.shape.radius = collider_radius * size_factor
	$CameraPivot/CameraArm.spring_length = arm_distance * size_factor
	$Mesh.scale = Vector3.ONE * size_factor
	$CameraPivot/Vacuum.set_size(size_factor)
	$CameraPivot/Vacuum.position = vacuum_offset * size_factor
	$CameraPivot/CameraArm/CameraOffset/Camera.position = camera_offset * size_factor


func _process_movement(delta):
	var input_velocity = Vector3.ZERO;
	input_velocity.y = target_velocity.y
	var cam_rotation = $CameraPivot/CameraArm.get_global_transform().basis.get_euler().y
	if Input.is_action_pressed("move_forward"):
		input_velocity.z -= 1
	if Input.is_action_pressed("move_back"):
		input_velocity.z += 1
	if Input.is_action_pressed("move_left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		input_velocity.x += 1
	target_velocity = input_velocity.rotated(Vector3.UP, cam_rotation)
	if Input.is_action_just_pressed("jump") && is_on_floor():
		target_velocity.y = jump_impulse * speed_size_curve.sample(size_key)
		FMODRuntime.play_one_shot_path("event:/PlayerJump")
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta * speed_size_curve.sample(size_key))
	
	velocity = target_velocity * speed * speed_size_curve.sample(size_key)


func _process_collisions():
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider().is_in_group("prop"):
			var prop = collision.get_collider()
			if Vector3.UP.dot(collision.get_normal()) < 0.2:
				print(prop.name)
				var force = collision_force
				if prop is PropBody and prop.min_force_size > size_factor:
					force = force * size_factor / prop.min_force_size
				prop.apply_force(-collision.get_normal() * force, collision.get_position())


func _input(event):
	if event is InputEventMouseMotion:
		var x_change = deg_to_rad(event.relative.x * x_sensitivity)
		if x_invert:
			x_change *= -1
		
		var y_change = deg_to_rad(event.relative.y * y_sensitivity)
		if y_invert:
			y_change *= -1
			
		$CameraPivot.rotation.y += x_change
		$CameraPivot.rotation.x = clamp($CameraPivot.rotation.x + y_change, 
				-deg_to_rad(low_angle), 
				deg_to_rad(high_angle))


func _physics_process(delta):
	_process_movement(delta)
	_process_shrink(delta)
	
	move_and_slide()
	_process_collisions()
