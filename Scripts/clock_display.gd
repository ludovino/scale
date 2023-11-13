extends Label

var time_bus = preload("res://Events/time_bus.tres")
var seconds_to_display = 9999

func _ready():
	time_bus.seconds_ticked.connect(_on_seconds_ticked)
	var tween = create_tween().set_loops()
	tween.tween_callback(toggle_colon).set_delay(0.5)

func toggle_colon():
	$Blink.visible = !$Blink.visible

func _on_seconds_ticked(seconds:int):
	seconds_to_display = seconds
	var min = seconds_to_display / 60
	var sec = seconds_to_display % 60
	text = "%02d %02d" % [min, sec]
