class_name SwimmingState
extends State

const water_slowing_koef = 0.5

func update(delta):
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	
	if direction.y > 0:
		_player.velocity = Vector2.ZERO
		_player.get_animation_player().play("dive")
		# can't move while under water
		return
	
	if Input.is_action_just_pressed("jump"):
		Transition.emit(self, "jump")
		return
	
	if direction.x != 0:
		direction.x = 1 if direction.x > 0 else -1	
	_player.velocity.x = direction.x * (_player.speed * water_slowing_koef)
	
	var is_shooting = Input.is_action_pressed("shoot")
	if not is_shooting:
		_player.get_animation_player().play("swim")
	else:
		if direction.y == 0:
			_player.get_animation_player().play("swim_n_shoot")
		elif direction.x == 0:
			_player.get_animation_player().play("swim_n_shoot_up_2")
		else:
			_player.get_animation_player().play("swim_n_shoot_up")
	
	if is_shooting:
		var rotation = 0
		var is_flipped = _player.get_sprite().flip_h
		if is_flipped:
			rotation = deg_to_rad(180)
		if direction.y < 0:
			if direction.x == 0:
				rotation = deg_to_rad(-90)
			else:
				rotation = deg_to_rad(-45) if not is_flipped else deg_to_rad(-135)
		_player.shoot(Vector2.RIGHT.rotated(rotation))

