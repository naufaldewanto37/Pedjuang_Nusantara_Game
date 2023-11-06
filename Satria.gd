extends CharacterBody2D

const SPEED = 200.0
const CROUCH_SPEED = 150.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 1000
const ATTACK_COOLDOWN = 0.5

var is_crouching = false
var is_attacking = false
var attack_timer = 0

@onready var satria = $AnimationSatria
@onready var satriaSprite = $SatriaSprite
@onready var collision_shape = $SatriaShape2D

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
		velocity.y = 0
	
	# Handle Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not is_crouching and not is_attacking:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			satria.play("jump")
	
	# Determine movement speed based on crouching
	var move_speed = SPEED
	if Input.is_action_pressed("ui_down") and is_on_floor():
		is_crouching = true
		move_speed = CROUCH_SPEED  # Use the crouch speed if crouching
		# Optionally adjust collision shape
		# collision_shape.set_deferred("disabled", true)
		
	# Handle attack
	if Input.is_action_just_pressed("attack") and attack_timer <= 0:
		is_attacking = true
		attack_timer = ATTACK_COOLDOWN
		satria.play("attack")
		# Optionally handle attack logic here (e.g., hit detection)
		if not is_on_floor():
			satria.play("JumpAttack")  # Assuming you have a different animation for jump attack
	
	# Only handle other movements if not attacking
	if not is_attacking:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * move_speed
			satriaSprite.flip_h = direction < 0
			if is_crouching:
				satria.play("crouchWalk")
		else:
			# Deselerasi karakter ketika tidak ada input movement
			velocity.x = move_toward(velocity.x, 0, move_speed * delta)

# Update the movement using move_and_slide
	move_and_slide()

	
	# Handle lookup without moving
	if Input.is_action_pressed("ui_up") and is_on_floor() and not is_crouching and velocity.x == 0:
		satria.play("lookup")
		return # Exit early to avoid playing other animations

	# Update animations based on movement
	if is_on_floor():
		if is_crouching:
			if velocity.x == 0:
				satria.play("crouch")  # Play crouch idle animation
		else:
			if is_attacking == false:
				if velocity.x != 0:
					satria.play("run")  # Play running animation
				elif not Input.is_action_pressed("ui_up"):
					satria.play("idle")  # Play idle animation
	elif not is_on_floor() and velocity.y > 0:
		satria.play("fall")  # Play falling animation



func _on_bambu_area_2d_body_entered(body):
	print("Hit Object Body")
	if body.is_in_group("Waluyo"):
		queue_free()
	pass
