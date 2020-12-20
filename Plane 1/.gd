extends AnimatedSprite

# class variables
const move_speed = 10
func _ready():
	set_process(true)
	set_process_input(true)# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _process(delta):
	var newPos =get_pos()
	var plane1 =get_node("plane1")
	#move up
	
	if(Input.is_action_pressed("player1_move_up")):
		newPos = Vector2(get_pos().x, get_pos().y - move_speed)
		if(get_viewport_rect().has_point(newPos)):
			set_pos(newPos)
			if(plane1.get_animation() != "move_up"):
				plane1.set_animation("move_up")
	elif(Input.is_action_pressed("player1_move_east")):
		newPos = Vector2(get_pos().x+move_speed , get_pos().y)
		if(get_viewport_rect().has_point(newPos)):
			set_pos(newPos)
			if(plane1.get_animation() != "move_east"):
				plane1.set_animation("move_east")
	elif(Input.is_action_pressed("player1_move_down")):
		newPos = Vector2(get_pos().x, get_pos().y + move_speed)
		if(get_viewport_rect().has_point(newPos)):
			set_pos(newPos)
			if(plane1.get_animation() != "move_down"):
				plane1.set_animation("move_down")
	elif(Input.is_action_pressed("player1_move_west")):
		newPos = Vector2(get_pos().x, get_pos().y - move_speed)
		if(get_viewport_rect().has_point(newPos)):
			set_pos(newPos)
			if(plane1.get_animation() != "move_west"):
				plane1.set_animation("move_west")
	else:
		plane1.set_animation("default")
		
		