extends Node

const SECTION = "SECTION"

var config = {
			"Server" : {
			"max_players" : 4,
			"password" : "",
			"port" : 7777,
			},
			"Controls" : {
			"move_up" : KEY_W,
			"move_down" : KEY_S,
			"move_left" : KEY_A,
			"move_right" : KEY_D,
			},
			"Player" : {
			"player_name" : "Noname",
			},
			}
			
func get_config(key):
	for section in config.keys():
		var subconfig = config[section]
		if subconfig.has(key):
			return subconfig[key]