extends Label

var score_bus = preload("res://score_bus.tres")

func _ready():
	score_bus.score_total_updated.connect(_on_score_total_updated)
	
func _on_score_total_updated(total:int):
	text = "$%s" % total
