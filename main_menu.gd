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
<<<<<<< HEAD
	get_tree().change_scene_to_file("res://level2.tscn")
=======
	pass # Replace with function body.



func _on_settings_pressed():
	get_tree().change_scene_to_file("res://setting.tscn")
>>>>>>> 0ea910ef875aa7b490ea58e7925628b21316d725
