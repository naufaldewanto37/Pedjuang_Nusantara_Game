extends CharacterBody2D
class_name BulletSatria

var direction = Vector2(1, 0)
@export var speed = Vector2(0, 0)

func _ready():
	#velocity.x = speed * direction
	velocity = speed * direction

func _physics_process(delta):
	if is_on_wall():
		queue_free()
	
	if is_on_floor():
		queue_free()
		
	if is_on_ceiling():
		queue_free()
		
	move_and_slide()
