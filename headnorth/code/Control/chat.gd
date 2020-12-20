extends Control

onready var chat = get_node("output")
var mousein = 0
var focused = 0

func _ready():
	chat.set_scroll_follow(true)

sync func server_message(msg):
	chat.set_bbcode(chat.get_bbcode() + str(msg," \n"))

sync func send_message(id,text):
	var username = NET.clients[id].clientname
	if(text == ""):
		return
	text = text.replace("[","(")
	text = text.replace("]",")")
	chat.set_bbcode(chat.get_bbcode() + str("[b]",username,":[/b] ",text," \n"))
	get_node("input").clear()

func _on_input_text_entered( text ):
	rpc("send_message",get_tree().get_network_unique_id(),text)

func _input(event):
	if event is InputEventMouseButton && !mousein:
		get_node("input").release_focus()

func _on_input_mouse_entered():
	mousein = 1


func _on_input_mouse_exited():
	mousein = 0



func _on_input_focus_entered():
	focused = 1
	get_node(CONST.PATH_GAMESTATE).inchat = 1


func _on_input_focus_exited():
	focused = 0
	get_node(CONST.PATH_GAMESTATE).inchat = 0

func _on_output_mouse_entered():
	chat.set_scroll_follow(false)


func _on_output_mouse_exited():
	chat.set_scroll_follow(true)
