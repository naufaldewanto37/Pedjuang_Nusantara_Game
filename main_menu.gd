extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Backsound.play()


func _on_exit_game_pressed():
	get_tree().quit()


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://cutscene_1.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://setting.tscn")


func _on_choose_stage_pressed():
	get_tree().change_scene_to_file("res://choose_stage.tscn")
