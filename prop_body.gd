extends RigidBody3D
class_name PropBody

@export var min_suck_size = 2.0
@export var min_force_size = 1.0
var meshes = []
signal sucked

func suck(new_parent: Node3D):
	for mesh in meshes:
		mesh.reparent(new_parent)
	sucked.emit()
	return meshes
