extends Area3D
class_name DirtArea
signal sucked
var triggered = false

# Called when the node enters the scene tree for the first time.
func suck(parent: Node3D):
	if triggered:
		return
	triggered = true
	$Mesh.reparent(parent)
	sucked.emit()
