class_name WeaponComponent
extends Node

@export var collision_mask: int = 0

var _gun: Gun: set = set_gun


func shoot(shooting_point: Vector2, direction: Vector2):
	_gun.shoot(shooting_point, direction)


func set_gun(new_gun: Gun):
	_gun = new_gun
	_gun.init(get_parent(), collision_mask)
