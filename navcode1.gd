extends Navigation2D

const move_speed = 6
var angle = 0
var path = []

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	var rand_angle = 0
	var upi = true
	var dooni = false
	var bot =get_node("bot")
	#if(get_viewport_rect().has_point(get_pos())):
	move(Vector2(move_speed*-1* cos(rand_angle),move_speed  * sin(rand_angle)))
	print(rand_angle)
	set_rot(rand_angle)
	if(rand_angle <= 6 and upi==true):
		rand_angle += 0.1
		if(rand_angle==6):
			upi == false
	elif(rand_angle>=0 and upi == false):
		rand_angle = rand_angle - 1.5
		if(rand_angle ==0 ):
			rand_angle= true
	path = get_simple_path(bot.get_pos(),Vector2(randi().x,randi().y))
	
	