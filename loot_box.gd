extends CharacterBody2D

@onready var boxAnim = $AnimationPlayer

var riffle = preload("res://Riffle.tscn")
var pistol = preload("res://pistol.tscn")
var health = 1

func _ready():
	boxAnim.play("box")

func take_damage(damage):
	# Mengurangi health box
	health -= damage
	boxAnim.play("destroy_box")
	
	
func _on_animation_player_animation_finished(anim_name):
		if anim_name == "destroy_box":
			var drop_instance = pistol.instantiate()
			get_parent().add_child(drop_instance)
			queue_free()

func _on_area_box_body_entered(body):
		if body.get_collision_layer() == 16:
			body.queue_free()
			boxAnim.play("destroy_box")
			take_damage(10)
