extends Control


@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var vb_complete: VBoxContainer = %VbComplete
@onready var finish_timer: Timer = %FinishTimer
@onready var music: AudioStreamPlayer = %Music
@onready var attempt_number_label: Label = %AttemptNumberLabel
@onready var level_number_label: Label = %LevelNumberLabel

var _total_cups: int = 0
var _curr_cups: int = 0
var _attempts: int = -1

func _ready() -> void:
	update_attempt()
	
	level_number_label.text = str(GameManager.current_level)
	_total_cups = get_tree().get_nodes_in_group(WoodCup.GROUP_NAME).size()
	_curr_cups = _total_cups
	
	SignalHub.launched.connect(update_attempt)
	SignalHub.vanished.connect(score)

func update_attempt() -> void:
	_attempts += 1
	attempt_number_label.text = str(_attempts)

func score() -> void:
	_curr_cups -= 1
	if _curr_cups == 0:
		finish_timer.start()

func show_completed() -> void:
	set_mouse_filter(Control.MOUSE_FILTER_STOP)
	
	vb_complete.show()
	animation_player.play("appear")
	music.play()

func _on_finish_timer_timeout() -> void:
	ScoreManager.update_level_scores(GameManager.current_level, _attempts)
	show_completed()
