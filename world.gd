extends Node2D

func _ready():
	$Backsound.play()

func _on_area_2d_body_entered(body):
	if body.is_in_group("satria"):
		get_tree().change_scene_to_file("res://cutscene_2.tscn")
			

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


func _on_instruct_1_body_entered(body):
	if body.is_in_group("satria"):
		$"Instruct 1/Label".visible = true
		

func _on_instruct_1_body_exited(body):
	if body.is_in_group("satria"):
		$"Instruct 1/Label".visible = false


func _on_instruct_2_body_entered(body):
	if body.is_in_group("satria"):
		$"Instruct 2/Label".visible = true


func _on_instruct_2_body_exited(body):
	if body.is_in_group("satria"):
		$"Instruct 2/Label".visible = false

func _on_instruct_3_body_entered(body):
	if body.is_in_group("satria"):
		$"Instruct 3/Label".visible = true
		

func _on_instruct_3_body_exited(body):
	if body.is_in_group("satria"):
		$"Instruct 3/Label".visible = false


func _on_instruct_4_body_entered(body):
	if body.is_in_group("satria"):
		$"Instruct 4/Label".visible = true


func _on_instruct_4_body_exited(body):
	if body.is_in_group("satria"):
		$"Instruct 4/Label".visible = false
