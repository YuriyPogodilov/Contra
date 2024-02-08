class_name Bullet
extends Area2D

@export var speed: float = 300

var _direction: Vector2

func _ready():
	_direction = Vector2.RIGHT.rotated(global_rotation)


func _physics_process(delta):
	position += _direction * speed * delta

	if !Camera.get_rect().has_point(global_position):
		queue_free()


func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		hitbox.damage(1)
		queue_free()
