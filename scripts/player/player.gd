class_name Player
extends CharacterBody2D

@export var gravity: float = 10
@export var speed: float = 100
@export var jump_force: float = 300


var is_shooting: bool = false
var _sm: StateMachine
var _sprite: Sprite2D
var _ap: AnimationPlayer

func _ready():
	_sprite = $Sprite2D
	_ap = $AnimationPlayer
	
	_sm = $StateMachine
	_sm.player = self
	_sm.start()


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	_sprite.flip_h = direction.x < 0
	
	is_shooting = Input.is_action_pressed("shoot")
	_sm.update(delta)
	
	move_and_slide()

func get_sprite() -> Sprite2D:
	return _sprite


func get_animation_player() -> AnimationPlayer:
	return _ap
