extends Node2D

func _ready():
	$Backsound.play()
	
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
