class_name DeathState
extends State

func enter(player: Player):
	super(player)
	
	_player.velocity.y = -100
	_player.velocity.x = 50 if _player.get_sprite().flip_h else -50
	_player.get_collision_shape().disabled = true
	
	_player.get_animation_player().play("death")
	
	get_tree().create_timer(0.8).timeout.connect(func(): _player.queue_free())
