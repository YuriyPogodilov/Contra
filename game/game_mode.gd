extends Node

@export var powerups_spawn_cooldows: float = 10.0

func _ready():
	get_tree().create_timer(powerups_spawn_cooldows).timeout.connect(spawn_powerups)


func spawn_powerups():
	pass
