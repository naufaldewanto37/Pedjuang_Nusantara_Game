extends Node2D


func _on_area_2d_body_entered(body):
	if body.is_in_group("satria"):
		body.has_gun = true  # Atau panggil fungsi di satria.gd untuk mengganti status senjata
		body.ammo = 10
