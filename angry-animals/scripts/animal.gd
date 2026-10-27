class_name Animal
extends RigidBody2D

@onready var stretch_sound: AudioStreamPlayer2D = %StretchSound
@onready var launch_sound: AudioStreamPlayer2D = %LaunchSound
@onready var kick_sound: AudioStreamPlayer2D = %KickSound
@onready var splash_sound: AudioStreamPlayer2D = %SplashSound

@onready var remove_timer: Timer = %RemoveTimer
@onready var debug: Label = %Debug
@onready var arrow_sprite: Sprite2D = %ArrowSprite

# Dragging variables 
@export var max_drag_distance: int = 50
@export var base_impulse: int = 200
@export var impulse_mult: int = 30

const IMPULSE_MAX = 14142

var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _is_dragging: bool = false
var _arrow_scale_x: float = 0.0


func _ready() -> void:
	_arrow_scale_x = arrow_sprite.scale.x
	
	SignalHub.launched.connect(is_released)
	SignalHub.fallen.connect(remove_animal)
	SignalHub.vanished.connect(wake_animal)

func _process(_delta: float) -> void:
	var debug_text = ""
	
	var impulse = calculate_impulse()
	debug_text += "Impulse: %d, %d\n" % [impulse.x, impulse.y]
	debug_text += "Length: %d" % impulse.length()
	
	debug.text = debug_text

func _physics_process(_delta: float) -> void:
	if _is_dragging:
		_dragged_vector.x = clamp(get_global_mouse_position().x,
		_drag_start.x - max_drag_distance,
		_drag_start.x + max_drag_distance
		)
		
		_dragged_vector.y = clamp(get_global_mouse_position().y,
		_drag_start.y - max_drag_distance,
		_drag_start.y + max_drag_distance
		)
		
		position = _dragged_vector
		scale_arrow()
	
	if  Input.is_action_just_released("drag") and _is_dragging:
		
		SignalHub.animal_launched()
	

func remove_animal() -> void: 
	splash_sound.play()
	remove_timer.start()

func handle_dragging() -> void:
	_is_dragging = true
	arrow_sprite.show()
	stretch_sound.play()
	_drag_start = get_global_mouse_position()

func is_released() -> void:
	freeze = false
	_is_dragging = false
	launch_sound.play()
	arrow_sprite.hide()
	apply_central_impulse(calculate_impulse())

func calculate_impulse() -> Vector2:
	return Vector2(
		(base_impulse * (_drag_start.x - _dragged_vector.x)/100 * impulse_mult), 
		(base_impulse * (_dragged_vector.y - _drag_start.y)/100 * -impulse_mult)
		)
		
func scale_arrow() -> void:
	var imp_len: float = calculate_impulse().length()
	var perc: float = clamp(imp_len / IMPULSE_MAX, 0.0, 1.0)
	
	arrow_sprite.scale.x = lerpf(_arrow_scale_x, _arrow_scale_x * 2, perc)
	arrow_sprite.rotation = (_start - position).angle()

func wake_animal() -> void:
	sleeping = false

func _on_remove_timer_timeout() -> void:
	queue_free()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		input_event.disconnect(_on_input_event)
		handle_dragging()

func _on_body_shape_entered(_body_rid: RID, _body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	if !kick_sound.playing:
		kick_sound.play()

func _on_sleeping_state_changed() -> void:
	get_colliding_bodies()[0].vanish()
	
