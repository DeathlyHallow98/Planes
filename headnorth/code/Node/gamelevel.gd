extends Node

export(String, FILE, "*.tscn") var initial_scene

func _ready():
	if(initial_scene):
		get_node(CONST.PATH_GAMESTATE).change_level(initial_scene)