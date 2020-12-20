extends KinematicBody2D

const DIR_UP = Vector2(0,-1)
const DIR_RIGHT = Vector2(1,0)
const DIR_DOWN = Vector2(0,1)
const DIR_LEFT = Vector2(-1,0)

export var max_speed = 150
export var density = 1
export var opacity = 1

var velocity = Vector2()
var direction = Vector2()
var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false
var speed = 0
var grid

slave var slave_position = Vector2()
slave var facing = DIR_DOWN

func gridmove(dir):
	if(is_moving):
		return
	if !grid.is_cell_dense(get_position(), dir):
		direction = dir
	facing = dir
	rset("facing",facing)
	_update_facing()

slave func set_base_sprite(framespath):
	if(framespath):
		var frames = load(framespath)
		get_node("sprites/base").frames = frames
		get_node("sprites/base").play(_get_direction_as_string())
		if(is_network_master()):
			rpc("set_base_sprite",frames)
		
slave func add_overlay(framespath):
	if(framespath):
		var newsprite = AnimatedSprite.new()
		var count = get_node("sprites/overlays").get_children().size()
		newsprite.set_name(str(count))
		if(count == 0):
			newsprite.set_z(get_node("sprites/base").get_z() + 1)
		else:
			newsprite.set_z(get_node(str("sprites/overlays/",count-1)).get_z() + 1)
		get_node("sprites/overlays").add_child(newsprite)
		var frames = load(framespath)
		newsprite.frames = frames
		newsprite.play(_get_direction_as_string())
		if(is_network_master()):
			rpc("add_overlay",frames)

slave func clear_overlays(framespath):
	for x in get_node("sprites/overlays").get_children():
		x.queue_free()

func set_target_pos(pos):
	target_pos = pos
	is_moving = true

func _ready():
	get_node("sprites/base").play(_get_direction_as_string())
	if(get_parent().grid.size() > 0): ##Checking if this node was made before or after the grid
		get_parent().call_deferred("assimilate",self)

func _process(delta):
	_process_movement(delta)
	_update_slave_position()
	
func _process_movement(delta):
	speed = 0

	if !is_moving && direction != Vector2():
		target_direction = direction.normalized()
		if !grid.is_cell_dense(get_position(), direction):
			grid.rpc("update_child_pos",get_position(),direction,self.get_path())
	elif is_moving:
		speed = max_speed
		velocity = speed * target_direction * delta

		var pos = get_position()
		var distance_to_target = pos.distance_to(target_pos)
		var move_distance = velocity.length()

		if move_distance > distance_to_target:
			velocity = target_direction * distance_to_target
			is_moving = false
			direction = Vector2()

		move_and_collide(velocity)

func _get_direction_as_string():
	if(facing == DIR_DOWN):
		return "down"
	if(facing == DIR_UP):
		return "up"
	if(facing == DIR_LEFT):
		return "left"
	if(facing == DIR_RIGHT):
		return "right"
		
func _update_slave_position():
	if(is_network_master()):
		rset("slave_position",get_position())
	else:
		set_position(slave_position)
		_update_facing()


func _update_facing():
	get_node("sprites/base").play(_get_direction_as_string())
	for x in get_node("sprites/overlays").get_children():
		x.play(_get_direction_as_string())