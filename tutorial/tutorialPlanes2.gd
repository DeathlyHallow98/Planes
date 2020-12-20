extends KinematicBody2D

var screen_size
var pos = Vector2()
const move_speed = 6
const rot_speed= 3
var gravity =0
var hp1
var bullet_delay=0.7
var timer = null
var can_shoot =  true
var angle = 0

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	screen_size = get_viewport().get_rect().size
	hp1 = 3# Called every time the node is added to the scene.
	pos = screen_size/2
	set_global_pos(pos)
	timer = get_node("Timer")
	timer.set_one_shot(true)
	timer.set_wait_time(bullet_delay)
	timer.connect("timeout" , self , "timeout_complete")
	
	
func timeout_complete():
	can_shoot = true
	
	
	
func _fixed_process(delta):
	
	
#	var plane1 =get_node("Plane1")
	Vector2(get_pos().x,get_pos().y - gravity)
	
	if(Input.is_action_pressed("player1_move_up")):
		move(Vector2(move_speed* cos(angle),move_speed * -1 * sin(angle)))
		gravity =1
	
	pos = get_global_pos()
	
	if pos.y <= 10 :
		move_speed=0
	if pos.y >= 20:
		move_speed=6
#	
	if pos.x >= screen_size.width:
		pos.x = 0
	if pos.x < 0:
		pos.x = screen_size.width
	set_global_pos(pos)	
	if(Input.is_action_pressed("fire1")):
		#move(Vector2(rot_speed * cos(angle),rot_speed * -1 * sin(angle)))
		#print(angle)
		angle = angle + 0.05
		
		set_rot(angle)
	
	if(Input.is_action_pressed("player1_move")):
		angle = angle - 0.05
		set_rot(angle)

	else:
		set_pos(Vector2(get_pos().x,get_pos().y+gravity))
		print(pos.y)

	#FIRING, BULLET

		
func _input(event):
	var projectile = preload("res://round/bullets.tscn")

#	var plane1 =get_node("Plane1")
	var bullet = projectile.instance()

	bullet.get_node("bullet_Shape").set_rot(angle)

	
	if(event.is_action_pressed("player1_shoot") and can_shoot):
		
		
		get_parent().add_child(bullet)
		bullet.fire(get_pos(), Vector2(6* cos(angle),move_speed * -1 * sin(angle)))
		can_shoot = false
		timer.start()
		

func update_health(val):
	hp1 -= val

		

 # replace with function body


#func _on_VB2D_exit_screen():
#	set_pos(get_pos().x- 1000)
#	print("I guess it works")
