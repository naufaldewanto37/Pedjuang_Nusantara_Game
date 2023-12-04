extends Node2D

@onready var Satria = $AnimationSatria

func _ready() -> void:
	Satria.play('idle')

func play_anim( animation_name ) -> void:
	Satria.play( animation_name )

func stop_anim() -> void:
	Satria.stop()
