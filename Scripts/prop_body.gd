extends RigidBody3D
class_name PropBody

@export var min_suck_size = 2.0
@export var min_force_size = 1.0
@export var score = -10

var score_bus = preload("res://Events/score_bus.tres") as ScoreBus
var meshes = []
var physics_objects = []
signal sucked

func suck(new_parent: Node3D):
	for mesh in meshes:
		mesh.reparent(new_parent)
	score_bus.add_to_score(score)
	sucked.emit()
	for item in physics_objects:
		if item == self:
			continue
		item.queue_free()
	queue_free()
