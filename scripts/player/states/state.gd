class_name State
extends Node


signal Transition(state: State, new_state: String)

var _player: Player


func enter(player: Player):
	_player = player


func update(delta):
	pass
