class_name Jumping
extends State


func enter(player: Player):
	_player = player


func update(delta):
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	_player.velocity.x = direction.x * _player.speed
	_player.get_animation_player().play("jump")

