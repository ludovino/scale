extends Node

class_name LevelController

@export var score = 0
@export var time_in_seconds = 180

var score_bus = preload("res://score_bus.tres") as ScoreBus
var seconds_remaining = 0

signal time_left_updated


# Called when the node enters the scene tree for the first time.
func _ready():
	score_bus.score_changed.connect(_on_score_changed)
	$Timer.wait_time = time_in_seconds
	seconds_remaining = time_in_seconds as int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var left = $Timer.time_left as int
	if left < seconds_remaining:
		seconds_remaining = left

func _on_score_changed(change:int):
	if($Timer.time_left > -1.0):
		score += change
		score_bus.update_score_total(score)
