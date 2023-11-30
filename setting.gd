extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_game_pressed():
	get_tree().quit()


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_load_game_pressed():
	get_tree().change_scene_to_file("res://level2.tscn")



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
