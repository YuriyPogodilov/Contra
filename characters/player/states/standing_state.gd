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

	if direction.y == 0:
		_player.get_animation_player().play("run_n_shoot")
		_player.get_animation_player().stop()
		_player.get_sprite().frame = 11
	elif direction.y < 0:
		_player.get_animation_player().play("shoot_up")
		if not is_shooting:
			_player.get_animation_player().stop()
			_player.get_sprite().frame = 12
	else:
		_player.get_animation_player().play("lay_n_shoot")
		if not is_shooting:
			_player.get_animation_player().stop()
			_player.get_sprite().frame = 14

	if is_shooting:
		_player.shoot(direction)
