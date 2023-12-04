extends Node2D

@onready var Waluyo = $WaluyoAnimation

func _ready() -> void:
	Waluyo.play('idle')

func play_anim( animation_name ) -> void:
	Waluyo.play( animation_name )

func stop_anim() -> void:
	Waluyo.stop()
