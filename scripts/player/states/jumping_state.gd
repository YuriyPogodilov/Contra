class_name JumpingState
extends State


func enter(player: Player):
	super(player)
	
	_player.velocity.y = -_player.jump_force


func update(delta):
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	if _player.is_on_floor():
		if direction.x == 0:
			Transition.emit(self, "stand")
		else:
			Transition.emit(self, "run")
		return

	_player.velocity.x = direction.x * _player.speed
	_player.get_animation_player().play("jump")
