extends Node


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Creditscene":
		get_tree().change_scene_to_file("res://main_menu.tscn")
