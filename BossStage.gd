extends Node2D

@onready var Boss = get_node("Boss/Boss")
@onready var batas = $StaticBody2D2

func _ready():
	$Backsound.play()

func _physics_process(delta):
	if Boss.boss_death == true and batas != null:
		batas.queue_free()
		while Boss.boss_death == true:
			$Label.visible = true


func _on_area_2d_body_entered(body):
	if body.is_in_group("satria"):
		get_tree().change_scene_to_file("res://after_boss.tscn")
		
		
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
