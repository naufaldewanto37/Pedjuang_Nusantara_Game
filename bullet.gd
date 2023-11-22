extends CharacterBody2D
class_name Bullet

var bullet_velocity = Vector2()
var direction = 1
@export var speed = 100

func _ready():
	velocity.x = speed * direction

func _physics_process(delta):
	move_and_slide()
