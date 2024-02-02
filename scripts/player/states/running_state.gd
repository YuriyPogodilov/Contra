class_name RunningState
extends State


func update(delta):
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
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
	
	if not _player.is_shooting:
		_player.get_animation_player().play("run")
	else:
		if direction.y == 0:
			_player.get_animation_player().play("run_n_shoot")
		elif direction.y > 0:
			_player.get_animation_player().play("run_n_shoot_down")
		else:
			_player.get_animation_player().play("run_n_shoot_up")