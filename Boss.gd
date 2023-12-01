extends CharacterBody2D

var BulletScene = preload("res://bullet_boss.tscn")
var boss_death = false
@onready var animBoss = $AnimationPlayer

var health = 50
var initial_speed = -8  # Menyimpan kecepatan awal
var SPEED = -8
var move_timer = 4
var move_cd = 4
var shooting_interval = 4  # Interval penembakan dalam detik
var shooting_timer = 0.0
var bullet_direction = 1

var facing_right = false
var seeing_satria = false
var attacking = false
	
func _physics_process(delta):
	if !boss_death:
		if attacking and shooting_timer <= 0 and seeing_satria and !boss_death:
			shoot_at_satria()
			shooting_timer = shooting_interval
		
		if shooting_timer > 0 and !boss_death:
			shooting_timer -= delta
		
		
		if !seeing_satria and !attacking and !boss_death:
			if move_timer > 0:
				move_timer -= delta
			elif move_timer <= 0:
				flip()
				
		velocity.x = SPEED
		move_and_slide()
	

	
func update_bullet_direction():
	if facing_right == true:
		bullet_direction = 1
	elif facing_right == false:
		bullet_direction = -1
	
func flip():
	if move_timer <= 0:
		move_timer = move_cd
		facing_right = !facing_right
		update_bullet_direction()
		scale.x = abs(scale.x) * -1
	if facing_right:
		SPEED = abs(initial_speed)
	else:
		SPEED = abs(initial_speed) * -1
	
func shoot_at_satria():
	if !boss_death:
		var bullet_instance = BulletScene.instantiate()
		bullet_instance.direction = bullet_direction  # Menetapkan arah gerak peluru
		get_parent().add_child(bullet_instance)
		bullet_instance.position.y = position.y + 5	
		bullet_instance.position.x = position.x + 20 * bullet_direction	

func take_damage(damage):
	health -= damage
	print(health)
	if health <= 0:
		die()
		
func die():
	animBoss.play("wrecked")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "wrecked":
		boss_death = true
		#get_tree().change_scene_to_file("res://main_menu.tscn")
	
	if anim_name == "prepare_shoot":
		animBoss.play("shoot")


func _on_area_boss_body_entered(body):
	if !boss_death:
		if body.position.x > self.position.x:
			flip()
		elif body.position.x < position.x:
			flip()
		seeing_satria = true
		animBoss.play("prepare_shoot")
		SPEED = 0
		seeing_satria = true
		attacking = true
		update_bullet_direction()
		shoot_at_satria()
	
		
func _on_area_boss_body_exited(body):
	if body.is_in_group("satria") and !boss_death:
		animBoss.play("Run")
		if !facing_right:
			SPEED = -abs(initial_speed)  # Bergerak ke kiri
			update_bullet_direction()
		else:
			SPEED = abs(initial_speed)  # Bergerak ke kanan
			update_bullet_direction()
		attacking = false
		seeing_satria = false
		
func _on_hurtbox_body_entered(body):
	if body.get_collision_layer() == 16 and !boss_death:
		body.queue_free()
		take_damage(10)
