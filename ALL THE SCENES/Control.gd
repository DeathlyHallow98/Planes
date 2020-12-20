extends Control



func _ready():
	# Called every time the node is added to the scene.
	set_process(true)# Initialization here
	pass
#func _process(delta):
	#var size =get_viewport().get_rect().size
	#print(".")#set_size(size)


func _on_start_pressed():
	print("playing")
	get_tree().change_scene("res://container.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://data/screens/KinematicBody2D.tscn")
	 # replace with function body
	print(".")