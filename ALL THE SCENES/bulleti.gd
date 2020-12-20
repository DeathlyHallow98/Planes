extends KinematicBody2D

const bullet_speed = 800
var shoot_dir = Vector2()
var hp1
var timer = null
var limit = true
var dest = preload("res://explosions/destroy.tscn")
var boom = dest.instance()
var end =false

 
func _ready():
	set_pos(Vector2(100, 100))
	hp1 = 3
	set_process_input(true)
 pass

func fire(position, direction):
	shoot_dir = direction.normalized()
	set_pos(position)
	
	set_fixed_process(true)

#func _process(delta):


func _fixed_process(delta):
	move(shoot_dir * bullet_speed * delta)



func _on_Area2D_body_enter( body ):
	var life = true
	var pos = body.get_pos()
	if(body.is_in_group("blue")):
		get_parent().update_HP1(1)
		body.update_health(1)
		print("health: " + str(body.hp1))
		queue_free()
		if(body.hp1 <= 0):
			
			
			get_parent().add_child(boom)
			boom.get_node("explosions").set_pos(pos)
			body.queue_free()
			end = true
			if(end != false):
				preload("res://Title Card/Control.tscn")
			if(Input.is_action_pressed("ui_accept") ):
					get_tree().change_scene("res://Title Card/Control.tscn")
			
			
#				var plane = preload("res://Plane 1/player1.tscn")
#				var blue = plane.instance()
#				get_parent().add_child(blue)
#				blue.set_pos(pos)