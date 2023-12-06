extends CharacterBody2D
class_name enemy

var health = 30
var initial_speed = -15  # Menyimpan kecepatan awal
var SPEED = -15
const JUMP_VELOCITY = -400.0
var move_timer = 4
var move_cd = 4
var shooting_interval = 3  # Interval penembakan dalam detik
var shooting_timer = 0.0
var bullet_direction = 1
var is_death = false

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
	if !is_death:
		if attacking and shooting_timer <= 0 and seeing_satria:
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
			elif move_timer <= 0:
				flip()
				
		velocity.x = SPEED
		move_and_slide()
	
func _on_attack_soldier_body_entered(body):
	if body.is_in_group("satria") and !is_death and !body.just_stood_up:
		soldier.play("attack")
		SPEED = 0  # Menghentikan prajurit ketika melihat Satria
		seeing_satria = true
		attacking = true
		update_bullet_direction()
		shoot_at_satria()


func _on_attack_soldier_body_exited(body):
	if body.is_in_group("satria") and !is_death:
		soldier.play("run")
		attacking = false
		seeing_satria = false
		if facing_right:
			SPEED = abs(initial_speed)
			update_bullet_direction()
		else:
			SPEED = abs(initial_speed) * -1
			update_bullet_direction()
			
func _on_vision_soldier_body_entered(body):
	if body.is_in_group("satria") and !is_death:
		if body.is_crouching:
			soldier.play("idle")
			SPEED = 0
			seeing_satria = false
		else:
			soldier.play("run")
			if !facing_right:
				SPEED = -abs(initial_speed)  # Bergerak ke kiri
				update_bullet_direction()
			else:
				SPEED = abs(initial_speed)  # Bergerak ke kanan
				update_bullet_direction()
			seeing_satria = true

func _on_vision_soldier_body_exited(body):
	if !is_death:
		soldier.play("run")
		if !seeing_satria:
			seeing_satria = false
			if facing_right:
				SPEED = abs(initial_speed)
				bullet_direction = 1
			else:
				SPEED = abs(initial_speed) * -1
				bullet_direction = -1
		elif seeing_satria:
			if body.is_in_group("satria") and body.is_on_floor() and !body.just_stood_up:
				soldier.play("attack")
				SPEED = 0  # Menghentikan prajurit ketika melihat Satria
				seeing_satria = true
			
func update_bullet_direction():
	if facing_right == true:
		bullet_direction = 1
	elif facing_right == false:
		bullet_direction = -1

func flip():
	if move_timer <= 0:
		move_timer = move_cd
		facing_right = !facing_right
		update_bullet_direction()
		scale.x = abs(scale.x) * -1
	if facing_right:
		SPEED = abs(initial_speed)
	else:
		SPEED = abs(initial_speed) * -1

func take_damage(damage):
	health -= damage
	if health <= 0:
		is_death = true
		die()
		
func die():
	$Death.play()
	soldier.play("death")

func _on_animation_soldier_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()

func shoot_at_satria():
	$Gun.play()
	var bullet_instance = BulletScene.instantiate()
	bullet_instance.direction = bullet_direction  # Menetapkan arah gerak peluru
	get_parent().add_child(bullet_instance)
	bullet_instance.position.y = position.y -5	
	bullet_instance.position.x = position.x + 20 * bullet_direction	

func _on_hurtbox_body_entered(body):
	if body.get_collision_layer() == 16:
		body.queue_free()
		take_damage(20)
