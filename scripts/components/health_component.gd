class_name HealthComponent
extends Node

signal onDied

@export var max_health: float  = 1.0
var _health: float


func _ready():
	_health = max_health


func take_damage(damage: float) -> bool:
	if damage < 0:
		return false
	_health -= damage
	clamp(_health, 0.0, max_health)
	if _health == 0.0:
		onDied.emit()
	return true


func take_heal(heal: float) -> bool:
	if heal < 0:
		return false
	_health += heal
	clamp(_health, 0.0, max_health)
	return true
