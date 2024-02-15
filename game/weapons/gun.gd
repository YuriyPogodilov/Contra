class_name Gun
extends Node

## Shots per second
@export var rate_of_fire: float
## Bullet as descendand of Bullet type
@export var bullet: PackedScene

var _owner: Node
var _is_on_cooldown: bool = false
var _cooldown_time: float = 1.0
var _collision_mask: = -1


func init(owner: Node, collision_mask: int):
	_owner = owner
	_collision_mask = collision_mask
	_cooldown_time = 1.0 / rate_of_fire


func start_cooldown():
	if _is_on_cooldown:
		return
	_is_on_cooldown = true
	_owner.get_tree().create_timer(_cooldown_time).timeout.connect(func(): _is_on_cooldown = false)

func shoot(shooting_point: Vector2, direction: Vector2):
	if _is_on_cooldown:
		return
	start_cooldown()
	
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = shooting_point
	new_bullet.global_rotation = Vector2.RIGHT.angle_to(direction)
	new_bullet.set_collision_mask_value(_collision_mask, true)
	_owner.add_child(new_bullet)
