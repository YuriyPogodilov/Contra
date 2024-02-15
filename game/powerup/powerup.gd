class_name Powerup
extends CharacterBody2D

@onready var sprite = $Sprite2D

var _is_flying: bool = true

var _guns = [ 
		preload("res://game/weapons/machine_gun.tscn"), 
		preload("res://game/weapons/shotgun.tscn")
	]
var _weapon_index = -1

func _physics_process(delta):
	if not _is_flying:
		velocity.y += 10
		if velocity.y > 1000:
			velocity.y = 1000
	
	move_and_slide()


func _on_health_component_died():
	_is_flying = false
	reveal_weapon()


func reveal_weapon():
	_weapon_index = randi() % _guns.size()
	sprite.frame = _weapon_index + 1


func _on_pickup_area_area_entered(area):
	assert(_weapon_index != -1)
	if area.get_parent() is Player:
		var player: Player = area.get_parent()
		var gun = _guns[_weapon_index].instantiate()
		player.pick_up_gun(gun)
		queue_free()

