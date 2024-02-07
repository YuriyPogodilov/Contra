class_name MainGUI
extends Control

var _player: Player


func _ready():
	_player = get_tree().get_first_node_in_group("Player")
	$HealthBar.max_value = _player.get_health_component().max_health
	$HealthBar.value = _player.get_health_component().get_health()
	_player.get_health_component().HealthChanged.connect(_on_player_health_changed)

func _on_player_health_changed(new_health: float, delta: float):
	$HealthBar.value = new_health
