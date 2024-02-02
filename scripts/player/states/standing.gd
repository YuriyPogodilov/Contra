class_name Standing
extends State


func enter(player: Player):
	_player = player


func update(delta):
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	_player.velocity.x = direction.x * _player.speed
	
	if Input.is_action_just_pressed("jump"):
		_player.velocity.y = -_player.jump_force

	
	if not _player.is_shooting:
		_player.get_animation_player().stop()
		if direction.y == 0:
			_player.get_sprite().frame = 11
		elif direction.y < 0:
			_player.get_sprite().frame = 12
		else:
			_player.get_sprite().frame = 14
	else:
		if direction.y == 0:
			_player.get_animation_player().stop()
			_player.get_sprite().frame = 11
		elif direction.y < 0:
			_player.get_animation_player().play("shoot_up")
		else:
			_player.get_animation_player().play("lay_n_shoot")
