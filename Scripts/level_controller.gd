extends Node

class_name LevelController

@export var score = 0
@export var time_in_seconds = 180
@export var tasks: Array[String] = []
var score_bus = preload("res://Events/score_bus.tres") as ScoreBus
var time_bus = preload("res://Events/time_bus.tres") as TimeBus
var seconds_remaining = 0

signal time_left_updated
signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	score_bus.score_changed.connect(_on_score_changed)
	$Timer.wait_time = time_in_seconds
	$Timer.start()
	$Timer.timeout.connect(time_up)
	seconds_remaining = time_in_seconds as int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var left = $Timer.time_left as int
	if left < seconds_remaining:
		seconds_remaining = left
		time_bus.tick_seconds(seconds_remaining)

func time_up():
	game_over.emit()

func _on_score_changed(change:int):
	if($Timer.time_left > -1.0):
		score += change
		score_bus.update_score_total(score, change)
