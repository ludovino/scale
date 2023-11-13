extends Resource

class_name TimeBus

signal seconds_ticked

func tick_seconds(seconds:int):
	seconds_ticked.emit(seconds)
