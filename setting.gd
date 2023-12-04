extends Node2D

func _on_exit_game_pressed():
	get_tree().quit()


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://cutscene_1.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://setting.tscn")


func _on_credits_pressed():
	pass # Replace with function body.


func _on_fullscreen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_brightness_slider_value_changed(value):
	GlobalWorldEnvironment.environment.adjustment_brightness = value
	print(value)


func _on_audio_pressed():
	get_tree().change_scene_to_file("res://audio.tscn")


func _on_choose_stage_pressed():
	get_tree().change_scene_to_file("res://choose_stage.tscn")


func _on_general_pressed():
	get_tree().change_scene_to_file("res://setting.tscn")
