extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Backsound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_game_pressed():
	get_tree().quit()


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://level_4.tscn")


func _on_load_game_pressed():
	get_tree().change_scene_to_file("res://BossStage.tscn")
	pass # Replace with function body.



func _on_settings_pressed():
	get_tree().change_scene_to_file("res://setting.tscn")
