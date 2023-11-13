extends CharacterBody2D

@export var speed : float = 200.0
@export var crouch_speed : float = 150.0
@export var JUMP_VELOCITY : float = -400.0
@export var double_jump_velocity : float = -200
const SPEED = 150.0
const CROUCH_SPEED = 100.0
const GRAVITY = 1000
const ATTACK_COOLDOWN = 0.5
var has_double_jumped : bool = false

var is_crouching = false
var is_attacking = false
var attack_timer = 0
var stuck_under_object = false
var is_jump = false

@onready var satria = $AnimationSatria
@onready var satriaSprite = $SatriaSprite
@onready var collision_shape = $SatriaShape2D
@onready var cshape = $SatriaShape2D

@onready var standing_cshape = $SatriaStandingShape2D
@onready var crouch_cshape = $SatriaCrouchingShape2D2
@onready var crouch_raycast1 = $CrouchRaycast1
@onready var crouch_raycast2 = $CrouchRaycast2

func _physics_process(delta):
	# Reset crouching state
	is_crouching = false
	
	if attack_timer > 0:
		attack_timer -= delta
		if attack_timer <= 0 and is_attacking:
			is_attacking = false
	
	# Handle gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		has_double_jumped = false
			
		
	
	# Handle Jump
	if Input.is_action_just_pressed("ui_accept") 	and not is_crouching and not is_attacking:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not is_crouching and not is_attacking and above_head_is_empty():
			if is_on_floor():
				crouch_cshape.disabled = true
				standing_cshape.disabled = false
				is_jump = true
				velocity.y = JUMP_VELOCITY
				satria.play("jump")
			elif not has_double_jumped:
				#double jump in the air
				velocity.y += double_jump_velocity
				has_double_jumped = true
	
	# Determine movement speed based on crouching
	var move_speed = speed
	if Input.is_action_pressed("ui_down") and is_on_floor():
		is_crouching = true
		move_speed = crouch_speed  # Use the crouch speed if crouching
		# Optionally adjust collision shape
		# collision_shape.set_deferred("disabled", true)
		move_speed = CROUCH_SPEED  # Use the crouch speed if crouching
		
	# Handle attack
	if Input.is_action_just_pressed("attack") and attack_timer <= 0:
		is_attacking = true
		attack_timer = ATTACK_COOLDOWN
		satria.play("attack")
		# Optionally handle attack logic here (e.g., hit detection)
		if not is_on_floor():
			is_attacking = true
			attack_timer = ATTACK_COOLDOWN
			satria.play("attack")  # Assuming you have a different animation for jump attack
	
	# Only handle other movements if not attacking
	if not is_attacking:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * move_speed
			satriaSprite.flip_h = direction < 0
			if Input.is_action_pressed("ui_down") and !is_jump:
				satria.play("crouchWalk")
				crouch_cshape.disabled = false
				standing_cshape.disabled = true
			elif Input.is_action_just_released("ui_down"):
				satria.play("crouch")
				crouch_cshape.disabled = false
				standing_cshape.disabled = true
		else:
			# Deselerasi karakter ketika tidak ada input movement
			velocity.x = move_toward(velocity.x, 0, move_speed * delta)

# Update the movement using move_and_slide
	move_and_slide()

	
	# Handle lookup without moving
	if Input.is_action_pressed("ui_up") and is_on_floor() and not is_crouching and above_head_is_empty() and velocity.x == 0:
		satria.play("lookup")
		return # Exit early to avoid playing other animations

	# Update animations based on movement
	if is_on_floor():
		if is_crouching:
			crouch_cshape.disabled = false
			standing_cshape.disabled = true
			if velocity.x == 0:
				satria.play("crouch")  # Play crouch idle animation
		else:
			if above_head_is_empty():
				crouch_cshape.disabled = true
				standing_cshape.disabled = false
				if is_attacking == false:
					if velocity.x != 0:
						satria.play("run")  # Play running animation
					elif not Input.is_action_pressed("ui_up"):
						satria.play("idle")  # Play idle animation
	elif not is_on_floor() and velocity.y > 0:
		crouch_cshape.disabled = true
		standing_cshape.disabled = false
		satria.play("fall")  # Play falling animation



func _on_bambu_area_2d_body_entered(body):
	if body.is_in_group("Waluyo"):
		print("Hit Object Body")
		queue_free()
	pass
	
func above_head_is_empty() -> bool:
	var result = !crouch_raycast1.is_colliding() && !crouch_raycast2.is_colliding()
	return result
