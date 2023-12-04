extends Node2D

@onready var Boss = $AnimationPlayer

func _ready() -> void:
	Boss.play('idle')

func play_anim( animation_name ) -> void:
	Boss.play( animation_name )

func stop_anim() -> void:
	Boss.stop()
