extends Node2D
var move = 0.9
var newPos 
func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	get_parent().set_offset(get_parent().get_offset() + (30 * delta))#newPos =Vector2(get_pos().x+move, get_pos().y )
	#set_pos(newPos)
	