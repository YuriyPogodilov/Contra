class_name Bullet
extends Area2D

@export var speed: float = 300

var _direction: Vector2
var _camera: PlayerCamera

func _ready():
	_direction = Vector2.RIGHT.rotated(global_rotation)
	_camera = get_tree().get_first_node_in_group("Camera")


func _physics_process(delta):
	position += _direction * speed * delta

	if !_camera.get_rect().has_point(global_position):
		queue_free()


func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		hitbox.damage(1)
		queue_free()
