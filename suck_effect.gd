extends Node3D
class_name SuckEffect

@export var suck_time = 0.5
signal suck_ended

func _ready():
	animate_children()

func _end_suck():
	suck_ended.emit()
	queue_free()

func animate_children():
	for child in get_children():
		if child is Camera3D:
			continue
		animate(child)

func animate(node: Node3D):
	var rng = RandomNumberGenerator.new()
	var tween = create_tween()
	tween.set_parallel()
	tween.set_ease(Tween.EASE_IN)
	tween.set_parallel()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(node, "position", Vector3.ZERO, suck_time)
	tween.tween_property(node, "scale", Vector3(0.001, 0.001, 0.001), suck_time)
	tween.tween_property(node, "rotation", Vector3(
			rng.randf_range(0.0, 20.0), 
			rng.randf_range(0.0, 20.0),
			rng.randf_range(0.0, 20.0)), suck_time).as_relative()
	tween.tween_callback(node.queue_free).set_delay(suck_time)
	tween.tween_callback(_end_suck).set_delay(suck_time)
