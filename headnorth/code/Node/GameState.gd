extends Node

var inchat = 0

func change_level(scenepath):
	for x in get_node(CONST.PATH_GAMELEVEL).get_children():
		x.queue_free()
	var new_level = load(scenepath).instance()
	get_node(CONST.PATH_GAMELEVEL).add_child(new_level)

#####################################
func _ready():
	pass