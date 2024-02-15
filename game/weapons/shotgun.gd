class_name Shotgun
extends Gun

## Bullets per shot
@export var bullets_per_shot: int
## Spread cone angle
@export var spread_cone_angle: float

func shoot(shooting_point: Vector2, direction: Vector2):
	if _is_on_cooldown:
		return
	start_cooldown()
	
	var rotation = Vector2.RIGHT.angle_to(direction)
	var rotation_step = deg_to_rad(spread_cone_angle) / float(bullets_per_shot - 1)
	var start_rotation = rotation - rotation_step * ((bullets_per_shot - 1)/ 2.0)
	for i in range(bullets_per_shot):
		var new_bullet = bullet.instantiate() 
		new_bullet.global_position = shooting_point
		new_bullet.global_rotation = start_rotation + rotation_step * i
		new_bullet.set_collision_mask_value(_collision_mask, true)
		_owner.get_tree().root.add_child(new_bullet)
