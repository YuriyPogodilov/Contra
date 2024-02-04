extends StaticBody2D

@export var rotation_speed = 0.6

var _player: Node2D


func _ready():
	_player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta):
	var player_direction = global_position.direction_to(_player.global_position)
	var head_direction = Vector2.RIGHT.rotated($Head.rotation)
	var dot = head_direction.dot(player_direction)
	if dot < 0.99:
		# TODO: chose correct direction of rotation (clockwise or counter clockwise)
		$Head.rotation += rotation_speed * delta
	if dot > 0.5:
		shoot()


func shoot():
	$WeaponComponent.shoot($Head/ShootingPoint.global_position, $Head.rotation)


func _on_health_component_died():
	queue_free()
