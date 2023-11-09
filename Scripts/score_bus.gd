extends Resource
class_name ScoreBus

signal score_changed

func _on_notify_score(change:int):
	print(change)
