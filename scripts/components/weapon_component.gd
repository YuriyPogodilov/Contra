class_name WeaponComponent
extends Node

@export var shooting_point: Marker2D
@export var cooldown_time: float = 0.3

const BULLET = preload("res://scenes/weapons/bullet.tscn")

var _is_on_cooldown = false

func shoot(shooting_point: Vector2, rotation: float):
	if _is_on_cooldown:
		return
	_is_on_cooldown = true
	
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = shooting_point
	new_bullet.global_rotation = rotation
	get_parent().add_child(new_bullet)
	
	get_tree().create_timer(cooldown_time).timeout.connect(func(): _is_on_cooldown = false)
