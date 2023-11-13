extends Label

var score_bus = preload("res://Events/score_bus.tres")

func _ready():
	score_bus.score_total_updated.connect(_on_score_total_updated)
	
func _on_score_total_updated(total:int, _change:int):
	#TODO: change effect - pulse scale and rotate
	#TODO: flash red / green depending on if the change is +ve or -ve
	text = "$%s" % total
