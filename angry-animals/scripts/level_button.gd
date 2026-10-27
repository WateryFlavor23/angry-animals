extends TextureButton


@onready var level_label: Label = %LevelLabel
@onready var score_label: Label = %ScoreLabel

@export var level_number: int = 1

func _ready() -> void:
	level_label.text = str(level_number)
	score_label.text = str(ScoreManager.get_best_score(level_number))
	
func _on_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)

func _on_mouse_exited() -> void:
	scale = Vector2(1.0, 1.0)

func _on_pressed() -> void:
	GameManager.load_level(level_number)
