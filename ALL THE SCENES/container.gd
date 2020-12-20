extends Node
var clouds_speed = 0.001
var clouds_location =0
var HP1 
var HP2
var life
var dest = preload("res://explosions/destroy.tscn")
var boom = dest.instance()


func _ready():
	HP1 = 3
	HP2 = 3
	set_process(true)
	set_fixed_process(true)

func _process(delta):
	var label = get_node("HP1")
	var label2 = get_node("HP2")
	label2.set_text("RED HP: " + str(HP2))
	label.set_text("BLUE HP: " + str(HP1))
	if(Input.is_action_pressed("end")):
		get_tree().change_scene("res://Title Card/Control.tscn")
func _set_fixed_process(delta):

	get_node("cloudpath/followCloud/clouds/Timer").set_unit_offset(clouds_location)
	clouds_location += clouds_speed
	#get_parent().set
	var plane1 = get_node("player1/Plane1")
	var plane2 = get_node("Player2/plane2")
	
	
	
func update_HP1(vali):
	HP1 -= vali

func update_HP2(value):
	HP2 -= value

func destroy2(boom):
	var pos1 = get_node("Player2/plane2").get_pos()
	var life = get_node("destroy/explosions").set_pos(pos1)
	get_parent().add_child(boom)
	



func _on_Area2D_body_enter( body ):
	var pos = body.get_pos()

	#if(body.is_in_group("red") or body.is_in_group("blue")):
	boom.get_node("explosions").set_pos(pos)
	body.queue_free()
		

