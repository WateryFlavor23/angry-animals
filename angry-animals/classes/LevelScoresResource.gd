class_name LevelScoresResource
extends Resource

const DEFAULT_SCORES: int = 9999

@export var level_scores: Dictionary[int, int]

func get_best_score(level_number: int) -> int:
	return level_scores.get(level_number, DEFAULT_SCORES)

func update_level_scores(level_number: int, score: int) -> void:
	if get_best_score(level_number) > score:
		level_scores[level_number] = score
