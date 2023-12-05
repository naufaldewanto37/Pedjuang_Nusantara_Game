extends Node2D

func _on_exit_game_pressed():
	get_tree().quit()

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://cutscene_1.tscn")
	
	
func _on_settings_pressed():
	get_tree().change_scene_to_file("res://setting.tscn")


func _on_choose_stage_pressed():
	get_tree().change_scene_to_file("res://choose_stage.tscn")

func _on_btn_lvl_1_pressed():
	get_tree().change_scene_to_file("res://cutscene_1.tscn")


func _on_btn_lvl_2_pressed():
	get_tree().change_scene_to_file("res://cutscene_2.tscn")


func _on_btn_lvl_3_pressed():
	get_tree().change_scene_to_file("res://cutscene_3.tscn")


func _on_btn_lvl_4_pressed():
	get_tree().change_scene_to_file("res://cutscene_4.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://credit_scene.tscn")
