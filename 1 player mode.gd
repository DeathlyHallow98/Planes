extends KinematicBody2D


var Speed = 6;
onready var plane2= get_node("Player2")

#var myPos = plane2.get_pos()
func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	
	var plane = get_node("enemy_plane")
	var angle =plane.get_rotd()
	if(plane2.get_rot()< 0):
		plane.set_rot(angle)
		angle = angle + 0.05
		
	if(plane2.get_rot()>0):
		plane.set_rot(angle)
		angle = angle -0.05

	print(plane2.get_rot())
	print("...")
	print(angle)

	

#	plane.look_at(  plane2.get_pos())
#	plane.set_rotd(plane.get_rotd()-90)
#Calculate the direction where we want to go, and normalize it
#	var direction = (plane2.get_pos() - plane.get_pos()).Normalized();
# Add gravity to y (y = up/down), so the character remains on the floor
#	direction.y = Player.g * delta;
#/* 
# * We can either use MoveAndCollide, or MoveAndSlide.
# * If we use MoveAndCollide, for some reason, multiply by delta
# */
#// this.MoveAndCollide(direction * delta * Player.SPEED);
#	move(Vector2(Speed* cos(angle),move_speed * -1 * sin(angle)))
#	move_to(Vector2(plane2.get_pos().x,plane2.get_pos().y))
	# Initialization here
#	pass
