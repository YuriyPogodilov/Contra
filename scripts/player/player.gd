class_name Player
extends CharacterBody2D

@export var gravity: float = 10
@export var speed: float = 100
@export var jump_force: float = 300

var _is_facing_right = true


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	
	if direction.x != 0:
		get_sprite().flip_h = direction.x < 0
	
	move_and_slide()


func shoot(rotation: float):
	var shooting_point = $ShootingPoint.global_position
	if get_sprite().flip_h:
		# flipping shooting point with sprite
		# kinda hardcode :thinking_face:
		# is there a better solution?
		shooting_point.x -= 2 * $ShootingPoint.position.x
	$WeaponComponent.shoot(shooting_point, rotation)


func get_sprite() -> Sprite2D:
	return $Sprite2D


func get_animation_player() -> AnimationPlayer:
	return $AnimationPlayer


func get_collision_shape() -> CollisionShape2D:
	return $CollisionShape2D

func get_aim_point() -> Vector2:
	return $AimPoint.global_position


func _on_health_component_on_died():
	queue_free()
