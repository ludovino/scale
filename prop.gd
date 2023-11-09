extends Node3D
class_name Prop

var physics_objects: Array[Node3D] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var propBody: PropBody
	var meshes = []
	for child in NodeExtensions.get_descendents(self):
		if child is Joint3D or child is RigidBody3D:
			physics_objects.append(child)
			child.add_to_group("prop")
		if child is PropBody:
			assert(propBody == null, "ERROR: only 1 PropBody per Prop")
			child.sucked.connect(_on_sucked)
			propBody = child
		if child is MeshInstance3D:
			meshes.append(child)
	assert(propBody != null, "ERROR: at least 1 PropBody per Prop")
	propBody.meshes = meshes.duplicate()

func _on_sucked():
	queue_free()
