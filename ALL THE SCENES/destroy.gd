#extends KinematicBody2D

var timer = Timer.new()
var allowed = true

func _ready():
	print("ready")
	set_process(true)
	set_fixed_process(true)
	add_child(timer)
	timer.set_wait_time(1)
	timer.set_one_shot(true)
	timer.connect("timeout" , self , "timeout_complete")
	timer.start()
	get_node("explosions").play("default")


func timeout_complete():
	allowed = true
	
	
func _fixed_process(delta):
	
	print("kaboom")
#	var explode = get_node("explosions")
#	
#	if(allowed):
#		explode.set_animation("default")
#		allowed= false
#	else:
#		print("hi")
#		explode.queue_free()
	


func _on_explosions_finished():
	queue_free()
