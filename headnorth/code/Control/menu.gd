extends Control

export(String, FILE, "*.tscn") var level_load

func _ready():
	NET.connect("connection_lost",self,"connection_failed")
	NET.connect("connection_authorized",self,"joined_game")
	NET.connect("server_startup_ok",self,"joined_game")
	get_node("panel/nameedit").set_text("NoName")

func joined_game():
	get_node(CONST.PATH_GAMESTATE).call_deferred("change_level",level_load)

func connection_failed():
	get_node("panel/mainmenu/hostmenubutton").set_disabled(0)
	get_node("panel/mainmenu/joinmenubutton").set_disabled(0)
	get_node("panel/joinmenu/joingame").set_disabled(0)
	get_node("panel/mainmenu/connecting_text").visible = 0

#main menu buttons
func _on_joinmenubutton_button_down():
	get_node("panel/hostmenu").visible = 0
	get_node("panel/joinmenu").visible = 1
func _on_hostmenubutton_button_down():
	get_node("panel/joinmenu").visible = 0
	get_node("panel/hostmenu").visible = 1


#hostmenu
func _on_hostgame_button_down():
	NET.host_server(int(get_node("panel/hostmenu/portedit").get_text()),int(get_node("panel/hostmenu/maxplayersedit").get_value()),get_node("panel/nameedit").get_text(),get_node("panel/hostmenu/passwordedit").get_text())

#joinmenu
func _on_joingame_button_down():
	get_node("panel/mainmenu/hostmenubutton").set_disabled(1)
	get_node("panel/mainmenu/joinmenubutton").set_disabled(1)
	get_node("panel/joinmenu/joingame").set_disabled(1)
	get_node("panel/connecting_text").visible = 1
	NET.join_server(get_node("panel/joinmenu/ipedit").get_text(),int(get_node("panel/joinmenu/portedit").get_text()),get_node("panel/nameedit").get_text(),get_node("panel/joinmenu/passwordedit").get_text())