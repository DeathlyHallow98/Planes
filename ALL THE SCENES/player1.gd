extends KinematicBody2D

# class variables
const move_speed = 6
const rot_speed= 3

var hp1
var bullet_delay=0.2
var timer = null
var can_shoot =  true
var angle = 0

 #angle of motion
func _ready():
	set_process(true)
	set_process_input(true)
	hp1 = 3# Called every time the node is added to the scene.
	# Initialization here
	pass
	timer = get_node("Timer")
	timer.set_one_shot(true)
	timer.set_wait_time(bullet_delay)
	timer.connect("timeout" , self , "timeout_complete")
	
	
func timeout_complete():
	can_shoot = true
	
	
	
func _process(delta):
	
	var newPos =get_pos()
	var plane1 =get_node("Plane1")

	if(Input.is_action_pressed("player1_move")):

		move(Vector2(move_speed* cos(angle),move_speed * -1 * sin(angle)))
		#newPos = Vector2(get_pos().x+move_speed , get_pos().y)

		print(get_pos().x)





	if(Input.is_action_pressed("player1_move_up")):
		#move(Vector2(rot_speed * cos(angle),rot_speed * -1 * sin(angle)))
		print(angle)
		angle = angle + 0.05
		
		set_rot(angle)


	
	
		
	if(Input.is_action_pressed("player1_move_down")):
		#move(Vector2(rot_speed* cos(angle),rot_speed * 1 * sin(angle)))

		angle = angle - 0.05

		set_rot(angle)

	
		

	#FIRING, BULLET

		
func _input(event):
	var projectile = preload("res://round/bullets.tscn")

	var plane1 =get_node("Plane1")
	var bullet = projectile.instance()

	bullet.get_node("bullet_Shape").set_rot(angle)

	
	if(event.is_action_pressed("fire1") and can_shoot):
		
		
		get_parent().add_child(bullet)
		bullet.fire(get_pos(), Vector2(6* cos(angle),move_speed * -1 * sin(angle)))
		can_shoot = false
		timer.start()
		

func update_health(val):
	hp1 -= val

		

 # replace with function body
