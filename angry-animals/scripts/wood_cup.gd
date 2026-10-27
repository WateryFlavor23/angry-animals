class_name WoodCup
extends StaticBody2D

const GROUP_NAME: String = "Cup"

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var vanish_timer: Timer = %VanishTimer

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func vanish() -> void:
	animation_player.play("vanish")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "vanish":
		SignalHub.cup_vanished()
		queue_free()
