extends Node2D

@onready var Boss = get_node("Boss/Boss")
@onready var batas = $StaticBody2D2

func _physics_process(delta):
	if Boss.boss_death == true and batas != null:
		batas.queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("satria"):
		get_tree().change_scene_to_file("res://main_menu.tscn")
