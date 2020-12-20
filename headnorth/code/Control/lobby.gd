extends Control

export(String, FILE, "*.tscn") var level_load

var countdown = 5

func _process(delta):
	get_node("panel/players").clear()
	for y in NET.clients:
		var x = NET.clients[y]
		if x.state != x.SPECTATOR:
			if x.state == x.PREGAME_UNREADY:
				get_node("panel/players").add_item(x.clientname)
			if x.state == x.PREGAME_READY:
				get_node("panel/players").add_item(str(x.clientname," (Ready)"))
				



func _on_ready_toggled( pressed ):
	if(pressed == true):
		NET.ready_up()
		if NET.check_players_ready():
			get_node("panel/chat").server_message("Game starting in 5")
			get_node("Timer").start()
	else:
		NET.cancel_ready_up()


func _on_Timer_timeout():
	if countdown > 1:
		countdown -= 1
		get_node("panel/chat").server_message(str("Game starting in ",countdown))
		if NET.check_players_ready():
				get_node("Timer").start()
		else:
			get_node("panel/chat").server_message("Game start canceled")
			get_node("Timer").stop()
			countdown = 5
	else:
		get_node("Timer").stop()
		set_process(false)
		get_node(CONST.PATH_GAMESTATE).call_deferred("change_level",level_load)
