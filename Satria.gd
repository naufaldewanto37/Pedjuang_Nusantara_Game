extends CharacterBody2D
class_name satria

@export var speed : float = 100
@export var JUMP_VELOCITY : float = -500.0
@export var double_jump_velocity : float = -200
@export var max_health : float = 50
const CROUCH_SPEED = 100.0
const GRAVITY = 1000
const ATTACK_COOLDOWN = 0.5
var has_double_jumped : bool = false

var is_crouching = false
var is_attacking = false
var attack_timer = 0
var is_jump = false
var attack_damage = 10

@onready var Satria = $AnimationSatria
@onready var satriaSprite = $SatriaSprite
@onready var cshape = $SatriaShape2D
@onready var bambu = $Bambu/BambuCollison
@onready var areaBambu = $Bambu

@onready var standing_cshape = $SatriaStandingShape2D
@onready var crouch_cshape = $SatriaCrouchingShape2D2
@onready var crouch_raycast1 = $CrouchRaycast1
@onready var crouch_raycast2 = $CrouchRaycast2

const FRICTION = 10.0
const ACCELERATION = 2000.0

func _physics_process(delta):
	bambu.disabled = true
	# Reset crouching state
	is_crouching = false
	
	if attack_timer > 0:
		attack_timer -= delta
		if attack_timer <= 0 and is_attacking:
			is_attacking = false
			
	# Apply friction to reduce sliding
	velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	# Handle gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
			
		
	# Handle Jump
	# Handle Jump
	if Input.is_action_just_pressed("ui_accept") and not is_crouching and not is_attacking and above_head_is_empty():
		if is_on_floor():
			crouch_cshape.disabled = true
			standing_cshape.disabled = false
			is_jump = true
			velocity.y = JUMP_VELOCITY
			Satria.play("jump")
		elif not has_double_jumped:
			# double jump in the air
			velocity.y += double_jump_velocity
			has_double_jumped = true
	
	# Determine movement speed based on crouching
	var move_speed = speed
	if Input.is_action_pressed("ui_down") and is_on_floor():
		is_crouching = true
		crouch_cshape.disabled = false
		standing_cshape.disabled = true
		move_speed = CROUCH_SPEED  # Use the crouch speed if crouching
		
	# Handle attack stand and jump
	if Input.is_action_just_pressed("attack") and attack_timer <= 0 and !is_crouching:
		is_attacking = true
		attack_timer = ATTACK_COOLDOWN
		Satria.play("attack")
		bambu.disabled = false
		if is_attacking and not bambu.disabled:
			var colliding_bodies = areaBambu.get_overlapping_bodies()
			for body in colliding_bodies:
				if body.is_in_group("Enemy"):
					body.take_damage(attack_damage)
		# Optionally handle attack logic here (e.g., hit detection)
		if not is_on_floor():
			is_attacking = true
			attack_timer = ATTACK_COOLDOWN
			Satria.play("attack")  # Assuming you have a different animation for jump attack
	
	# Only handle other movements if not attacking
	if not is_attacking:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * move_speed
			if direction < 0:
				satriaSprite.flip_h = true
				bambu.position.x = -76
				if Input.is_action_pressed("ui_down") and !is_jump:
					Satria.play("crouchWalk")
					crouch_cshape.disabled = false
					standing_cshape.disabled = true
				elif Input.is_action_just_released("ui_down"):
					Satria.play("crouch")
					crouch_cshape.disabled = false
					standing_cshape.disabled = true
			elif direction > 0:
				satriaSprite.flip_h = false
				bambu.position.x = 76
				if Input.is_action_pressed("ui_down") and !is_jump:
					Satria.play("crouchWalk")
					crouch_cshape.disabled = false
					standing_cshape.disabled = true
				elif Input.is_action_just_released("ui_down"):
					Satria.play("crouch")
					crouch_cshape.disabled = false
					standing_cshape.disabled = true
		else:
			# Deselerasi karakter ketika tidak ada input movement
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)

	# Update the movement using move_and_slide
	move_and_slide()

	
	# Handle lookup without moving
	if Input.is_action_pressed("ui_up") and is_on_floor() and not is_crouching and above_head_is_empty() and velocity.x == 0:
		Satria.play("lookup")
		return # Exit early to avoid playing other animations

	# Update animations based on movement
	if is_on_floor():
		if velocity == Vector2(0, 0):
			Satria.play("idle")
		if is_crouching:
			crouch_cshape.disabled = false
			standing_cshape.disabled = true
			if velocity.x == 0:
				Satria.play("crouch")  # Play crouch idle animation
		else:
			if above_head_is_empty():
				crouch_cshape.disabled = true
				standing_cshape.disabled = false
				if is_attacking == false:
					if velocity.x != 0:
						Satria.play("run")  # Play running animation
					
	elif not is_on_floor() and velocity.y > 0:
		crouch_cshape.disabled = true
		standing_cshape.disabled = false
		Satria.play("fall")  # Play falling animation

	
func above_head_is_empty() -> bool:
	var result = !crouch_raycast1.is_colliding() && !crouch_raycast2.is_colliding()
	return result
	

func _on_bambu_body_entered(body):
	if body.is_in_group("Enemy"):
		body.take_damage(attack_damage)

func take_damage(damage):
	max_health -= damage
	if max_health <= 0:
		die()
			

func die():
	Satria.play("death")

func _on_animation_satria_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()  # Atau handle game over logic
		get_tree().change_scene_to_file("res://main_menu.tscn")
