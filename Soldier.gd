extends CharacterBody2D
class_name enemy

var health = 20
var initial_speed = -15  # Menyimpan kecepatan awal
var SPEED = -15
const JUMP_VELOCITY = -400.0
var move_timer = 4
var move_cd = 4
var shooting_interval = 3  # Interval penembakan dalam detik
var shooting_timer = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var soldier = $AnimationSoldier
@onready var raycast1 = $RayCast2D
@onready var SoldierSprite = $SoldierSprite2D
@onready var Satria = get_parent().get_parent().get_node("Character/Satria")

var facing_right = false

var seeing_satria = false
var attacking = false

var BulletScene = preload("res://bullet.tscn")


func _ready():
	soldier.play("run")

func _physics_process(delta):
	print(facing_right)
	if attacking and shooting_timer <= 0:
		shoot_at_satria()
		shooting_timer = shooting_interval
	
	if shooting_timer > 0:
		shooting_timer -= delta
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !seeing_satria and !attacking:
		if move_timer > 0:
			move_timer -= delta
			if !raycast1.is_colliding() && is_on_floor():
				flip()
		else:
			flip()
			
	velocity.x = SPEED
	move_and_slide()
	
func _on_attack_soldier_body_entered(body):
	if body.is_in_group("satria"):
		soldier.play("attack")
		SPEED = 0  # Menghentikan prajurit ketika melihat Satria
		seeing_satria = true
		attacking = true
		shoot_at_satria()


func _on_attack_soldier_body_exited(body):
	if body.is_in_group("satria"):
		soldier.play("run")
		attacking = false
		seeing_satria = false
		if facing_right:
			SPEED = abs(initial_speed)
		else:
			SPEED = abs(initial_speed) * -1
			
func _on_vision_soldier_body_entered(body):
	if body.is_in_group("satria") or body.is_in_group("Satria"):
		if body.is_crouching:
			soldier.play("idle")
			SPEED = 0
			seeing_satria = false
		else:
			soldier.play("run")
			if !facing_right:
				SPEED = -abs(initial_speed)  # Bergerak ke kiri
			else:
				SPEED = abs(initial_speed)  # Bergerak ke kanan
			seeing_satria = true

func _on_vision_soldier_body_exited(body):
	soldier.play("run")
	if !seeing_satria:
		seeing_satria = false
		if facing_right:
			SPEED = abs(initial_speed)
		else:
			SPEED = abs(initial_speed) * -1
	elif seeing_satria and !Satria.is_crouching:
		if body.is_in_group("satria"):
			soldier.play("attack")
			SPEED = 0  # Menghentikan prajurit ketika melihat Satria
			seeing_satria = true
			attacking = true
			shoot_at_satria()

func flip():
	move_timer = move_cd
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		SPEED = abs(initial_speed)
	else:
		SPEED = abs(initial_speed) * -1

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
		
func die():
	soldier.play("death")

func _on_animation_soldier_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()

func shoot_at_satria():
	var bullet_direction
	var bullet_instance = BulletScene.instantiate()
	get_parent().add_child(bullet_instance)
	bullet_instance.position.y = position.y -5
	if facing_right:
		bullet_instance.position.x = position.x + 20 * 1
	elif !facing_right:
		bullet_instance.position.x = position.x + 20 * -1
	



func _on_hurtbox_body_entered(body):
	if body.get_collision_layer() == 16:
		body.queue_free()
		take_damage(10)
