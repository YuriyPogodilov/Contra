class_name Bullet
extends Area2D

@export var speed: float = 300.0
@export var damage: float = 1.0

var _direction: Vector2

func _ready():
	top_level = true
	_direction = Vector2.RIGHT.rotated(global_rotation)


func _physics_process(delta):
	position += _direction * speed * delta

	if !Camera.get_rect().has_point(global_position):
		queue_free()


func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		hitbox.damage(damage)
		queue_free()
