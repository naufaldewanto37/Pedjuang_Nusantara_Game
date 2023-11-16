extends Node2D
class_name Bullet

var damage = 10
@export var speed = 100
var direction: Vector2

func _physics_process(delta):
	position -= direction * speed * delta

func _on_bullet_body_entered(body):
	if body.is_in_group("satria"):
		body.take_damage(damage)
		queue_free()

func set_target(target_position):
	direction = (target_position - position).normalized()
