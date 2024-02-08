class_name WeaponComponent
extends Node

@export var collision_mask: int = 0

const SIMPLE_GUN = preload("res://game/weapons/simple_gun.tres")

@export var gun: Gun: set = set_gun

var _is_on_cooldown: bool = false
var _cooldown_time: float = 1.0

func _ready():
	if gun == null:
		gun = SIMPLE_GUN
	set_gun(gun)


func set_gun(new_gun: Gun):
	if gun != new_gun:
		gun = new_gun
		_cooldown_time = 1.0 / gun.rate_of_fire


func shoot(shooting_point: Vector2, rotation: float):
	if _is_on_cooldown:
		return
	_is_on_cooldown = true
	
	var new_bullet = gun.ammo.instantiate()
	new_bullet.global_position = shooting_point
	new_bullet.global_rotation = rotation
	new_bullet.set_collision_mask_value(collision_mask, true)
	get_tree().root.add_child(new_bullet)
	
	get_tree().create_timer(_cooldown_time).timeout.connect(func(): _is_on_cooldown = false)
