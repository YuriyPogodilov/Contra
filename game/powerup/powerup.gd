class_name Powerup
extends CharacterBody2D

@onready var sprite = $Sprite2D

var _is_flying: bool = true
var _is_weapon_revealed: bool = false
var _start_position: Vector2

var _guns = [ 
		"res://game/weapons/machine_gun.tscn", 
		"res://game/weapons/shotgun.tscn"
	]
var _weapon_index = -1


func _ready():
	_start_position = global_position


func _physics_process(delta):
	if _is_flying:
		var speed = 50
		global_position.x += speed * delta
		global_position.y = _start_position.y + 15 * sin(0.1 * global_position.x)
	else:
		velocity.y += 10
		if velocity.y > 1000:
			velocity.y = 1000
	
	move_and_slide()


func _on_health_component_died():
	_is_flying = false
	reveal_weapon()


func reveal_weapon():
	if (_is_weapon_revealed):
		return
	_is_weapon_revealed = true
	set_collision_mask_value(1, true)
	_weapon_index = randi() % _guns.size()
	sprite.frame = _weapon_index + 1


func _on_pickup_area_area_entered(area):
	if !_is_weapon_revealed:
		return
	if area.get_parent() is Player:
		var player: Player = area.get_parent()
		var gun = load(_guns[_weapon_index]).instantiate()
		player.pick_up_gun(gun)
		queue_free()

