tool
extends TileMap

enum ENTITY_TYPES {PLAYER, OBSTACLE, COLLECTIBLE}

export var grid_size = Vector2(16, 9)

var grid = []

func get_cell_contents(pos=Vector2()):
	return grid[pos.x][pos.y]


func is_cell_dense(pos=Vector2(), direction=Vector2()):
	var grid_pos = world_to_map(pos) + direction

	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			for x in grid[grid_pos.x][grid_pos.y]:
				if(x.density):
					return true
			return false
	return true

func assimilate(node):
	node.grid = self
	var pos_on_grid = world_to_map(node.get_position())
	pos_on_grid.x = max(min(pos_on_grid.x,grid_size.x),0)
	pos_on_grid.y = max(min(pos_on_grid.y,grid_size.y),0)
	node.set_position(map_to_world(pos_on_grid) + (cell_size / 2))
	grid[pos_on_grid.x][pos_on_grid.y].append(node)
	

sync func update_child_pos(new_pos, direction, node_path):
	# Remove node from current cell, add it to the new cell, returns the new target move_to position
	var node = get_node(node_path)
	var grid_pos = world_to_map(new_pos)
	grid[grid_pos.x][grid_pos.y].erase(node)
	
	var new_grid_pos = grid_pos + direction
	grid[new_grid_pos.x][new_grid_pos.y].append(node)
	
	var target_pos = map_to_world(new_grid_pos) + (cell_size / 2)
	node.set_target_pos(target_pos)

func _ready():
	if Engine.is_editor_hint():
		return
	set_network_master(1)
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append([])

	# Assimilate nodes
	for x in get_children():
		assimilate(x)

############# In Editor Functions ###############
func _draw():
	if Engine.is_editor_hint():
		draw_rect(Rect2(Vector2(0,0),Vector2(cell_size.x * grid_size.x,cell_size.y * grid_size.y)),Color(255, 255, 255),false)