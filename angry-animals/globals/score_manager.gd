extends Node

const SCORES_PATH = "rsc/level_scores.tres"
var _level_scores: LevelScoresResource = LevelScoresResource.new()

func _ready() -> void:
	load_scores_from_file()

func get_best_score(level_number: int) -> int:
	return _level_scores.get_best_score(level_number)
	
func update_level_scores(level_number: int, score: int) -> void:
	_level_scores.update_level_scores(level_number, score)
	save_scores_from_file()

func load_scores_from_file() -> void:
	if ResourceLoader.exists(SCORES_PATH):
		_level_scores = load(SCORES_PATH)

func save_scores_from_file() -> void:
	ResourceSaver.save(_level_scores, SCORES_PATH)
