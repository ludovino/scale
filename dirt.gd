extends Node3D

@export var score = 1

func _on_sucked():
	var tween = create_tween()
	tween.tween_property($Particles, "amount", 1, 3)
	tween.tween_callback(queue_free)


func _on_dirt_area_sucked():
	$DirtArea.queue_free()
