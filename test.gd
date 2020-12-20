extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var screen_size
var pos = Vector2()
var newPos = Vector2()
const move_speed = 6

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	set_process_input(true)
	screen_size = get_viewport().get_rect().size
#	pos = screen_size/2
#	set_pos(pos)
	
func _process(delta):
	var tester = get_node("Sprite")
	if(Input.is_action_pressed("ui_right")):
		Vector2(1,0)
	
	if pos.x >= screen_size.width:
		pos.x =0
	if pos.x < 0:
		pos.x = screen_size.width
