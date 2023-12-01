extends Node2D


func _on_area_2d_body_entered(body):
	if body.is_in_group("satria"):
		body.current_health = min(body.current_health + body.heart_value, body.max_health)
		
		# Periksa apakah objek $CanvasLayer/HealthBar ada dan valid
		if $CanvasLayer/HealthBar:
			$CanvasLayer/HealthBar.value = body.current_health
		
		queue_free()  # Hancurkan item jantung setelah dikumpulkan
		body.on_heart_collected()  # Panggil fungsi saat jantung terkumpul
