extends Control





onready var anim_player = get_node("anim_player")
onready var anim_player2 = get_node("anim_player 2")
#var is_loading = true

func _ready():
	set_process_input(true)

	fade_in_out()
	
func _input(event):
	if(event.is_action_pressed("ui_accept")):
		#next_scene()
		get_tree().change_scene("res://Title Card/control.tscn")
		print("passed this")
	
func fade_in_out():
	anim_player.play("fade_in_out")
	anim_player2.play("Credits")
	#anim_player.connect("finished" , self , "go_to_next_scene")
	print("fadein")

		

		
