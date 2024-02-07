class_name Powerup
extends CharacterBody2D

var _is_flying: bool = true

func _physics_process(delta):
	if not _is_flying:
		velocity.y += 10
		if velocity.y > 1000:
			velocity.y = 1000
	
	move_and_slide()


func _on_health_component_died():
	_is_flying = false
	reveal_weapon()


func reveal_weapon():
	# TODO:
	pass


func _on_pickup_area_area_entered(area):
	if area.get_parent() is Player:
		queue_free()

