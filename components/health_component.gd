class_name HealthComponent
extends Node

signal HealthChanged(new_health: float, delta: float)
signal Died

@export var max_health: float = 1.0

var _health: float : get = get_health

func _ready():
	_health = max_health


func get_health() -> float:
	return _health


func _apply_health_change(value) -> bool:
	var new_health = _health + value
	clamp(new_health, 0.0, max_health)
	var delta = new_health - _health
	if delta == 0:
		return false
	
	_health = new_health
	HealthChanged.emit(new_health, delta)
	
	if _health <= 0.0:
		Died.emit()
	
	return true


func take_damage(damage: float) -> bool:
	if damage < 0:
		return false
	
	return _apply_health_change(-damage)


func take_heal(heal: float) -> bool:
	if heal < 0:
		return false
	
	return _apply_health_change(heal)
