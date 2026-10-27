extends Node

const LEVEL_1 = preload("res://scenes/level_1.tscn")
const LEVEL_2 = preload("res://scenes/level_2.tscn")
const LEVEL_3 = preload("res://scenes/level_3.tscn")
const MAIN = preload("res://scenes/main.tscn")

var current_level = 0

func load_level(level_number: int) -> void:
	match level_number:
		1: 
			current_level = 1
			get_tree().change_scene_to_packed(LEVEL_1)
		2: 
			current_level = 2
			get_tree().change_scene_to_packed(LEVEL_2)
		3: 
			current_level = 3
			get_tree().change_scene_to_packed(LEVEL_3)

func load_main() -> void:
	get_tree().change_scene_to_packed(MAIN)
