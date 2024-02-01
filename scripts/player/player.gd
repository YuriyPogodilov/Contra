extends CharacterBody2D


@export var gravity = 10
@export var speed = 100
@export var jump_force = 50

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	velocity.x = direction.x * speed
	
	var is_shooting = Input.is_action_pressed("shoot")
	if is_shooting:
		# TODO: shoot
		pass
	
	if Input.is_action_just_pressed("jump"):
		if velocity.y == 0:
			velocity.y = -jump_force
	
	if direction.x != 0:
		sprite.flip_h = (direction.x < 0)
	
	move_and_slide()
	
	update_animation(direction, is_shooting)


func update_animation(direction, is_shooting):
	# TODO: convert to a state machine pattern
	if is_on_floor():
		if direction.x != 0:
			if not is_shooting:
				ap.play("run")
			else:
				if direction.y == 0:
					ap.play("run_n_shoot")
				elif direction.y > 0:
					ap.play("run_n_shoot_down")
				else:
					ap.play("run_n_shoot_up")
		else:
			if not is_shooting:
				ap.stop()
				if direction.y == 0:
					sprite.frame = 11
				elif direction.y < 0:
					sprite.frame = 12
				else:
					sprite.frame = 14
			else:
				if direction.y == 0:
					ap.stop()
					sprite.frame = 11
				elif direction.y < 0:
					ap.play("shoot_up")
				else:
					ap.play("lay_n_shoot")
	else:
		ap.play("jump")
