extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine = $AnimationTree.get('parameters/playback')
@onready var soldier = $AnimationSoldier
@onready var vision_area = $VisionAreaSoldier # Ganti dengan path yang benar


func _ready():
	state_machine.travel('idle')

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		soldier.play("attack")


	move_and_slide()
	
func _on_vision_area_soldier_body_entered(body):
	print("Body entered: ", body.name)
	if body.is_in_group('satria'):
		soldier.play("attack")
