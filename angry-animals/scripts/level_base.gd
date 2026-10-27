extends Node

@onready var spawn_point: Marker2D = %SpawnPoint

const ANIMAL: PackedScene = preload("uid://ckcis8rtsggxd")


func _ready() -> void:
	SignalHub.fallen.connect(summon_bird)
	summon_bird()

func summon_bird() -> void:
	var bird_instance: Animal = ANIMAL.instantiate()
	call_deferred("add_child", bird_instance)
	
	bird_instance.position = spawn_point.position
	bird_instance._start = spawn_point.position

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("return"):
		GameManager.load_main()
