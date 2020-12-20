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
	pass
	timing = get_node("Timer")
	timing.set_one_shot(true)
	timing.set_wait_time(bulleti_delay)
	timing.connect("timeout" , self ,"time_complete")
	
func time_complete():
	is_shoot = true
	
func _process(delta):
	var newPos =get_pos()
	var plane2 =get_node("plane2")
	var hp = 3



	if(Input.is_action_pressed("player2_move_west")):
		move(Vector2(move_speed*-1* cos(angles),move_speed  *  sin(angles)))
		#newPos = Vector2(get_pos().x+move_speed , get_pos().y)



	if(Input.is_action_pressed("player2_move_up")):
		angles = angles - 0.05
		set_rot(angles)
		#newPos = Vector2(get_pos().x, get_pos().y - move_speed)

	



	#move_NE
	elif(Input.is_action_pressed("player2_move_down")):
		angles = angles + 0.05

		set_rot(angles)
		

		


	#FIRING, BULLET
func _input(event):
	var projecti = preload("res://round/bulleti.tscn")
	#var bullet_shape = get_node("bullet_shape")
	var plane2 =get_node("plane2")
	var bulleti = projecti.instance()
	#if(plane2.get_animation() == "move_NE"):
	bulleti.get_node("bullet-shape").set_rot(angles)


	
	if(event.is_action_pressed("fire2") and is_shoot):
		
		
		get_parent().add_child(bulleti)
	#	bulleti.fire(get_pos(), Vector2(move_speed* cos(angles),move_speed  * sin(angle)))
		bulleti.fire(get_pos(), Vector2(6* cos(angles) * -1 ,move_speed * sin(angles)))
		is_shoot = false
		timing.start()
		
	#else:
	#	if(angles != -90):
		#	angles - 0.05
		#move(Vector2(move_speed*-1* cos(angles),move_speed  *  sin(angles)))
func update_health(val):
	hp2 -= val

		