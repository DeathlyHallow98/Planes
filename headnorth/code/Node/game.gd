extends Node

onready var spawns = get_node("spawns").get_children()

func _ready():
	call_deferred("_ready_deferred")
	
func _ready_deferred():
	for y in NET.clients:
		var x = NET.clients[y]
		if(x.state == x.SPECTATOR):
			continue
		var newplayer = preload("res://scenes/grid_entity/player.tscn").instance()
		get_node("grid").add_child(newplayer)
		newplayer.set_name(str(x.id))
		newplayer.set_network_master(x.id)
		newplayer.set_position(spawns[0].get_position())
		spawns.erase(spawns[0])
