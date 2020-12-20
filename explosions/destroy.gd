#extends KinematicBody2D

#var timer = Timer.new()
#var allowed = true

func _ready():
#3	print("ready")
	set_process(true)
	set_fixed_process(true)




#func timeout_complete():
	#allowed = true
	
	
func _fixed_process(delta):
	
	print("kaboom")
#	var explode = get_node("explosions")
	get_node("explosions").play("default")

	
#	if(allowed):
#		explode.set_animation("default")
#		allowed= false
#	else:
#		print("hi")
#		explode.queue_free()
	


func _on_explosions_finished():
	queue_free()
