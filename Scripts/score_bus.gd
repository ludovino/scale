extends Resource
class_name ScoreBus

signal score_changed
signal score_total_updated

func add_to_score(change:int):
	print("change score: ", change)
	score_changed.emit(change)

func update_score_total(total:int):
	print("total score: ", total)
	score_total_updated.emit(total)
