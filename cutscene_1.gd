extends Node

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Cutscene":
		get_tree().change_scene_to_file("res://world.tscn")



func _on_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
