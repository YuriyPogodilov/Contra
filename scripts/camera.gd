class_name PlayerCamera
extends Camera2D

@export var player: Player


func _physics_process(delta):
	if player != null:
		global_position.x = player.global_position.x

func get_rect() -> Rect2:
	var view_port_size = get_viewport_rect().size
	return Rect2(global_position - view_port_size / 2, global_position + view_port_size / 2) 
