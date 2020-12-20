extends KinematicBody2D

# class variables
const move_speed = 6

var hp2
var bulleti_delay=0.2
var timing = null
var is_shoot =  true
var angles = 0 #angle of motion

func _ready():
	set_process(true)
	set_process_input(true)
	hp2 = 3# Called every time the node is added to the scene.
	# Initialization here

	
func time_complete():
	is_shoot = true
	
func _process(delta):
	var newPos =get_pos()
	#var plane2 =get_node("plane2")
	var hp = 3
	


	if(Input.is_action_pressed("ui_accept")):
			get_tree().change_scene("res://Title Card/Control.tscn")

		


	#FIRING, BULLET




		
	#else:
	#	if(angles != -90):
		#	angles - 0.05
		#move(

		

func _on_Area2D_body_enter( body ):
	# replace with function body
	body.queue_free()