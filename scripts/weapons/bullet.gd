class_name Bullet
extends Area2D

@export var speed: float = 300

var direction


func _ready():
	direction = Vector2.RIGHT.rotated(global_rotation)


func _physics_process(delta):
	position += direction * speed * delta
	
	#var view_port = get_viewport_rect()
	#if !view_port.has_point(global_position):
		#queue_free()


func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		hitbox.damage(1)
		queue_free()
