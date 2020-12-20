extends Node
var clouds_speed = 0.001
var clouds_location =0
var HP1 
var done = false
var HP2
var timer = null
var life
var p1win = false
var p2win = false
onready var win1 = get_node("Player_1_win")
onready var win2 = get_node("Player2_win")
var dest = preload("res://explosions/destroy.tscn")
onready var pause =get_node("pause_menu")
var boom = dest.instance()
onready var BL3 =get_node("BL3")
onready var BL1 =get_node("BL1")
onready var BL2 =get_node("BL2")
onready var RL3 =get_node("RL3")
onready var RL1 =get_node("RL1")
onready var RL2 =get_node("RL2")

func _ready():
	win1.hide()
	win2.hide()
	pause.hide()
	HP1 = 3
	HP2 = 3
	timer = get_node("Timer")
	timer.set_one_shot(true)
	timer.set_wait_time(2)
	timer.connect("timeout" , self , "timeout_complete")
	
	set_process(true)
	set_fixed_process(true)

func timeout_complete():
	get_tree().change_scene("res://Title Card/Control.tscn")
	
func _process(delta):
	
	var label = get_node("HP1")
	var label2 = get_node("HP2")
	label2.set_text("RED HP: " + str(HP2))
	label.set_text("BLUE HP: " + str(HP1))
	if(Input.is_action_pressed("end")):
			get_tree().set_pause(true)
			pause.show()
	if(Input.is_action_pressed("ui_accept") and (p1win )):
		get_tree().change_scene("res://Title Card/Control.tscn")
#		get_tree().change_scene("res://Title Card/Control.tscn")
func _set_fixed_process(delta):

	get_node("cloudpath/followCloud/clouds/Timer").set_unit_offset(clouds_location)
	clouds_location += clouds_speed
	#get_parent().set
	var plane1 = get_node("player1/Plane1")
	var plane2 = get_node("Player2/plane2")
#	if(done):
#		get_tree().change_scene("res://Title Card/Control.tscn")
	
	
func update_HP1(vali):
	HP1 -= vali
	if(HP1 == 2):
		BL1.queue_free()
	if(HP1 == 1):
		BL2.queue_free()
	if(HP1 == 0):
		BL3.queue_free()
#		audio_player.play("explosion_sound")
		win2.show()
		p1win = true
		timer.start()
func update_HP2(value):
	HP2 -= value
	if(HP2 == 2):
		RL1.queue_free()
	if(HP2 == 1):
		RL2.queue_free()
	if(HP2 == 0):
		RL3.queue_free()
		audio_player.play("explosion_effect")
		win1.show()
		p1win = true
		timer.start()

func destroy2(boom):
	var pos1 = get_node("Player2/plane2").get_pos()
	var life = get_node("destroy/explosions").set_pos(pos1)
#	get_parent().add_child(boom)
	



func _on_Area2D_body_enter( body ):
	var pos = body.get_pos()


	get_parent().add_child(boom)
	boom.set_pos(pos)
	audio_player.play("explosion_effect")
#	get_tree().change_scene("res://Title Card/Control.tscn")
	body.queue_free()

	if(body.is_in_group("red")):
		win1.show()
		timer.start()
		p1win = true

	if(body.is_in_group("blue")):
		win2.show()
		timer.start()
		
		p1win = true

