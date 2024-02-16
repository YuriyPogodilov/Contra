extends StaticBody2D

@onready var shooting_point = $Head/ShootingPoint

@export var rotation_speed = 0.6
@export_range(-180, 180, 45) var initial_rotaion: int = 0

var _player: Player
var _rotation_delta: float = 0.0
var _rotation_step: float = deg_to_rad(45.0)
var _aiming_accuracy: float = deg_to_rad(30.0)


func _ready():
	_player = get_tree().get_first_node_in_group("Player")
	$Head.rotation = deg_to_rad(initial_rotaion)
	$WeaponComponent.set_gun(preload("res://game/weapons/turret_gun.tscn").instantiate())


func _physics_process(delta):
	if !Camera.get_rect().has_point(global_position):
		return
	
	if _player == null:
		return
	var player_direction = $Head.global_position.direction_to(_player.get_aim_point())
	var head_direction = Vector2.RIGHT.rotated($Head.rotation)
	var angle = head_direction.angle_to(player_direction)
	if abs(angle) >= _aiming_accuracy:
		_rotation_delta += rotation_speed * delta
		if (abs(_rotation_delta) > _rotation_step):
			var turn_clockwise = 1 if angle > 0 else -1
			$Head.rotation += turn_clockwise * _rotation_step
			_rotation_delta = 0.0
	else:
		shoot()


func shoot():
	$WeaponComponent.shoot(shooting_point.global_position, Vector2.RIGHT.rotated($Head.rotation))


func _on_health_component_died():
	queue_free()
