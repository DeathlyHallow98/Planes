extends "res://code/KinematicBody2D/grid_entity.gd"

var inputs = []

func _input(event):
	if(is_network_master()):
		if (event.is_class("InputEventKey")) && !event.is_echo():
			if(get_node(CONST.PATH_GAMESTATE).inchat):
				return
			var directions = {
					DIR_UP: CONFIG.get_config("move_up"),
					DIR_DOWN: CONFIG.get_config("move_down"),
					DIR_LEFT: CONFIG.get_config("move_left"),
					DIR_RIGHT: CONFIG.get_config("move_right")
					}
			for x in directions:
				if event.scancode == directions[x]:
					if(event.is_pressed()):
						inputs.insert(0,x)
					else:
						inputs.erase(x)

func _process(delta):
	_process_controls(delta)
		
func _process_controls(delta):
	if inputs.size():
		gridmove(inputs[0])
