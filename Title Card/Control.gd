extends Control

onready var anime = get_node("anime")
onready var clouds = get_node("clouds_cover")
onready var planes = get_node("planes")
func _ready():
	
	clouds()
	planes()
	# Called every time the node is added to the scene.
	set_process(true)# Initialization here
	cloudy()

#func _process(delta):
	#var size =get_viewport().get_rect().size
	#print(".")#set_size(size)


func _on_start_pressed():
	print("playing")
	get_tree().change_scene("res://ALL THE SCENES/container.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://ALL THE SCENES/KinematicBody2D.tscn")
	 # replace with function body
	#print(".")
	
func cloudy():
	anime.play("clouds and plane")
		
func clouds():
	clouds.play("cloud_cover")
	
func planes():
	planes.play("planimation")