class_name JumpingState
extends State


func enter(player: Player):
	super(player)
	
	_player.velocity.y = -_player.jump_force
	_player.get_collision_shape().disabled = true
	
	_player.get_animation_player().play("jump")


func update(delta):
	if _player.velocity.y > 0:
		_player.get_collision_shape().disabled = false
	
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	if _player.is_on_floor():
		if _player.global_position.y > 310:
			Transition.emit(self, "swim")
		elif direction.x == 0:
			Transition.emit(self, "stand")
		else:
			Transition.emit(self, "run")
		return

	_player.velocity.x = direction.x * _player.speed

