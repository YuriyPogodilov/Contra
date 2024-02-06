extends StaticBody2D

@export var rotation_speed = 0.6
@export_range(-180, 180, 5) var initial_rotaion: int = 0

var _player: Player


func _ready():
	_player = get_tree().get_first_node_in_group("Player")
	$Head.rotation = deg_to_rad(initial_rotaion)


func _physics_process(delta):
	if _player == null:
		return

	var player_direction = $Head.global_position.direction_to(_player.get_aim_point())
	var head_direction = Vector2.RIGHT.rotated($Head.rotation)
	var angle = head_direction.angle_to(player_direction)
	if angle != 0:
		var turn_clockwise = 1 if angle > 0 else -1
		$Head.rotation += turn_clockwise * rotation_speed * delta
		if abs(angle) < deg_to_rad(10):
			shoot()


func shoot():
	$WeaponComponent.shoot($Head/ShootingPoint.global_position, $Head.rotation)



func _on_health_component_on_died():
	queue_free()
