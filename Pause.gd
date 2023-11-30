extends Control

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("pause"):
		print("Pause pressed. Current pause state: ", get_tree().paused)
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
