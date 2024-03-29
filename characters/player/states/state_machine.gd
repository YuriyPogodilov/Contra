class_name StateMachine
extends Node

@export var initial_state: State
@export var player: Player

var _current_state: State
var _states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			_states[child.name.to_lower()] = child
			child.Transition.connect(on_child_transition)
	
	_current_state = initial_state
	_current_state.enter(player)


func update(delta):
	if _current_state:
		_current_state.update(delta)


func on_child_transition(state: State, new_state_name: String):
	if state != _current_state:
		return

	set_state(new_state_name)


func set_state(new_state_name: String):
	var new_state = _states.get(new_state_name.to_lower())
	if !new_state:
		return
	_current_state = new_state
	_current_state.enter(player)

