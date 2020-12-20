extends KinematicBody2D

const bullet_speed = 1000
var shoot_dir = Vector2()
var dest = preload("res://explosions/destroy.tscn")
var i=0
var limit = true
var boom = dest.instance()

func _ready():
	
	set_process_input(true)
	
 set_pos(Vector2(100, 100))
 pass

func fire(position, direction):
	shoot_dir = direction.normalized()
	set_pos(position)

	set_fixed_process(true)
	
func _fixed_process(delta):
	move(shoot_dir * bullet_speed * delta)

func _on_Area2D_body_enter( body ): #use this function

	var life = true
	var pos = body.get_pos()
	
	if(body.is_in_group("red")): 
		
		get_parent().update_HP2(1)
		body.update_health(1)
		print("health: " + str(body.hp2))
		body.get_pos()
		queue_free()
		if(body.hp2 <= 0):
			audio_player.play("explosion_effect")
			get_parent().add_child(boom)
			boom.get_node("explosions").set_pos(pos)
			if(Input.is_action_pressed("ui_select")):
				get_tree().change_scene("res://Title Card/Control.tscn")
			
			#boom.stop()
			
			#var projectile = preload("res://round/bullets.tscn")


	#bullet.get_node("bullet_Shape").set_rot(angle)
			body.queue_free()
			limit = false 
			
func timeout_complete(delta):
	#var pos=boom.get_pos()
	#get_parent().add_child(boom)
	boom.queue_free()
	#dest.is_queued_for_deletion()
