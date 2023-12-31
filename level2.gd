extends Node2D

func _ready():
	$Backsound.play()


func _on_finished_area_body_entered(body):
	if body.is_in_group("satria"):
		get_tree().change_scene_to_file("res://cutscene_3.tscn")
		

func _input(event):
	if event.is_action_pressed("pause"):
		pauseMenu()

@onready var pause_Menu = $Pause/PauseMenu
var paused = false

func pauseMenu():
	if paused:
		pause_Menu.hide()
		Engine.time_scale = 1
	else:
		pause_Menu.show()
		Engine.time_scale = 0
	
	paused = !paused
