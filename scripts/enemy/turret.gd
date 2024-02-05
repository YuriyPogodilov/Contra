extends StaticBody2D

@export var rotation_speed = 0.6

var _player: Player


func _ready():
	_player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta):
	var player_direction = global_position.direction_to(_player.get_aim_point())
	var head_direction = Vector2.RIGHT.rotated($Head.rotation)
	var dot = head_direction.dot(player_direction)
	if dot < 0.99:
		var angle = head_direction.angle_to(player_direction)
		var turn_clockwise = 1 if angle > 0 else -1
		$Head.rotation += turn_clockwise * rotation_speed * delta
	if dot > 0.7:
		shoot()


func shoot():
	$WeaponComponent.shoot($Head/ShootingPoint.global_position, $Head.rotation)


func _on_health_component_died():
	queue_free()
