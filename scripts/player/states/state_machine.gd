class_name StateMachine
extends Node


@export var initial_state: State

var player: Player
var _current_state: State

func start():
	set_state(initial_state)

func update(delta):
	var direction = Input.get_vector("move_left", "move_right", "look_up", "look_down")
	if not player.is_on_floor():
		set_state($Jumping)
	elif direction.x == 0:
		set_state($Standing)
	else:
		set_state($Running)
	
	_current_state.update(delta)


func set_state(new_state: State) -> bool:
	if _current_state == new_state:
		return false
	
	_current_state = new_state
	_current_state.enter(player)
	return true
