extends Node

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Cutscene":
		get_tree().change_scene_to_file("res://world.tscn")
