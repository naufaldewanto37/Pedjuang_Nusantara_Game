extends Node

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "cutscene":
		get_tree().change_scene_to_file("res://level2.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://level2.tscn")
