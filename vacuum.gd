extends Node3D

@export var suck_power = 50

var bodies = []
var size = 1.0
var pull_radius
var pull_height
var consume_radius
var pull_offset
var consume_offset
# Called when the node enters the scene tree for the first time.
func _ready():
	pull_radius = $PullArea/PullCollider.shape.radius
	pull_height = $PullArea/PullCollider.shape.height
	pull_offset = $PullArea.position
	consume_radius = $ConsumeArea/ConsumeCollider.shape.radius
	consume_offset = $ConsumeArea.position

func set_size(size:float):
	self.size = size
	$PullArea/PullCollider.shape.radius = pull_radius * size
	$PullArea/PullCollider.shape.height = pull_height * size
	$ConsumeArea/ConsumeCollider.shape.radius = consume_radius * size
	$Scaleable.scale = Vector3.ONE * size
	$PullArea.position = pull_offset * size
	$ConsumeArea.position = consume_offset * size
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("suck"):
		print("suck")
		$PullArea/PullCollider.disabled = false;
		$ConsumeArea/ConsumeCollider.disabled = false;
	if Input.is_action_just_released("suck"):
		print("no suck")
		$PullArea/PullCollider.disabled = true;
		$ConsumeArea/ConsumeCollider.disabled = true;
	for body in bodies:
		print(body.name)
		var power = 1.0/maxf(1.0, global_position.distance_squared_to(body.global_position))
		var direction = (global_position - body.global_position).normalized()
		body.apply_central_force(direction * power * suck_power)


func _on_pull_area_body_entered(body):
	bodies.append(body)


func _on_pull_area_body_exited(body):
	bodies.erase(body)


func _on_consume_area_body_entered(body):
	print("body:", body.name)
	print("can suck:", body.has_method("suck"))
	if body.has_method("suck") && body.min_suck_size < size:
		print("SUCKED")
		var suckEffect = SuckEffect.new()
		add_child(suckEffect)
		suckEffect.basis = Basis.IDENTITY
		body.suck(suckEffect)
		suckEffect.animate_children()


func _on_pull_area_area_entered(area):
	print("area:", area.name)
	if area.has_method("suck"):
		print("SUCKED")
		var suckEffect = SuckEffect.new()
		add_child(suckEffect)
		suckEffect.basis = Basis.IDENTITY
		area.suck(suckEffect)
		suckEffect.animate_children()
