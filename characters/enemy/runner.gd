extends CharacterBody2D

@export var speed: float = 50
@export var gravity: float = 10

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

var _direction: int = -1
var _is_dead: bool = false

func _ready():
	animation_player.play("run")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000

	if _direction != 0:
		sprite.flip_h = _direction < 0

	if not _is_dead:
		velocity.x = _direction * speed

	move_and_slide()



func _on_health_component_died():
	_is_dead = true
	animation_player.stop(true)
	velocity.y = -100
	velocity.x = 100 if sprite.flip_h else -100
	await get_tree().create_timer(0.4).timeout
	queue_free()
