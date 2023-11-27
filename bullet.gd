extends CharacterBody2D
class_name Bullet

var bullet_velocity = Vector2()
var direction = 1
@export var speed = 150

func _ready():
	velocity.x = speed * direction

func _physics_process(delta):
	if is_on_wall():
		queue_free()
	
	if is_on_floor():
		queue_free()
		
	if is_on_ceiling():
		queue_free()
	
	move_and_slide()

