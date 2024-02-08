class_name PlayerCamera
extends Camera2D


func update_position(new_position: Vector2):
	if new_position.x > global_position.x:
		global_position.x = new_position.x


func get_rect() -> Rect2:
	var view_port_size = get_viewport_rect().size
	return Rect2(global_position - view_port_size / 2, global_position + view_port_size / 2) 
