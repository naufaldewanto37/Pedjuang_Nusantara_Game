extends Node2D


func _on_area_2d_body_entered(body):
	if body.is_in_group("satria"):
		pass
		#get_tree().change_scene_to_file("res://BossStage.tscn")
