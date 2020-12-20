extends Container



func _ready():
	set_process_input(true)
	pass


func _on_Menu_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://Title Card/Control.tscn")
	audio_player.play("menu_select")



func _on_resume_pressed():
	get_tree().set_pause(false)
	hide()
	pass # replace with function body
	
	



func _on_Resart_pressed():
	get_tree().set_pause(false)
	audio_player.play("menu_select")
	get_tree().change_scene("res://ALL THE SCENES/container.tscn")
