class_name RunningState
extends State


func update(delta):
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	if direction.x != 0:
		direction.x = 1 if direction.x > 0 else -1
	_player.velocity.x = direction.x * _player.speed
	
	if Input.is_action_just_pressed("jump"):
		Transition.emit(self, "jump")
		return
	
	if direction.x == 0:
		Transition.emit(self, "stand")
		return
	elif not _player.is_on_floor():
		Transition.emit(self, "fall")
		return
	
	var is_shooting = Input.is_action_pressed("shoot")
	if not is_shooting:
		_player.get_animation_player().play("run")
	else:
		if direction.y == 0:
			_player.get_animation_player().play("run_n_shoot")
		elif direction.y > 0:
			_player.get_animation_player().play("run_n_shoot_down")
		else:
			_player.get_animation_player().play("run_n_shoot_up")
	
	if is_shooting:
		var rotation = 0
		var is_flipped = _player.get_sprite().flip_h
		if is_flipped:
			rotation = deg_to_rad(180)
		if direction.y < 0:
			rotation = deg_to_rad(-45) if not is_flipped else deg_to_rad(-135)
		elif direction.y > 0:
			rotation = deg_to_rad(45) if not is_flipped else deg_to_rad(135)
		_player.shoot(Vector2.RIGHT.rotated(rotation))
