extends Control

@onready var main = $"../../"

func _on_continue_pressed():
	main.pauseMenu()
