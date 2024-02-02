class_name FallingState
extends State

func enter(player: Player):
	super(player)
	
	_player.get_collision_shape().disabled = true
	get_tree().create_timer(0.3).timeout.connect(func(): _player.get_collision_shape().disabled = false)


func update(delta):
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	if _player.is_on_floor():
		if direction.x == 0:
			Transition.emit(self, "stand")
		else:
			Transition.emit(self, "run")

	_player.get_sprite().frame = 11

