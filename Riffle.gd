extends Node2D


func _on_area_2d_body_entered(body):
	if body.is_in_group("satria"):
		if body.is_crouching:
			body.has_gun = true
			body.has_pistol = false
			body.ammo = 10
			queue_free()
