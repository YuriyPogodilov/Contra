class_name StandingState
extends State


func update(delta):
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	_player.velocity.x = direction.x * _player.speed
	
	if Input.is_action_just_pressed("jump"):
		if direction.y > 0:
			Transition.emit(self, "fall")
		else:
			Transition.emit(self, "jump")
		return

	if direction.x != 0:
		Transition.emit(self, "run")
		return
	
	var is_shooting = Input.is_action_pressed("shoot")
	if not is_shooting:
		_player.get_animation_player().stop()
		if direction.y == 0:
			_player.get_sprite().frame = 11
		elif direction.y < 0:
			_player.get_sprite().frame = 12
		else:
			_player.get_sprite().frame = 14
	else:
		if direction.y == 0:
			# hardcode for reseting shooting point
			_player.get_animation_player().play("run_n_shoot")
			_player.get_animation_player().stop()
			_player.get_sprite().frame = 11
		elif direction.y < 0:
			_player.get_animation_player().play("shoot_up")
		else:
			_player.get_animation_player().play("lay_n_shoot")

	if is_shooting:
		var rotation = 0
		if _player.get_sprite().flip_h:
			rotation = deg_to_rad(180)
		if direction.y < 0:
			rotation = deg_to_rad(-90)
		_player.shoot(rotation)
