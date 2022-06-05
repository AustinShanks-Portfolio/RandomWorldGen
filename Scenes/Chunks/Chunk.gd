class_name Chunk
extends TileMap

enum {WATER, SAND, DIRT, GRASS, SNOW}

var hp: Dictionary = {}
var floor_cells: PackedByteArray = []
var object_cells: PackedByteArray = []
var roof_cells: PackedByteArray = []

func _ready() -> void:
#	render()
	pass
	
func render() -> void:
	for i in floor_cells.size():
		var cell = Vector2i(i % 32, i / 32)
		set_cell(0, cell, 0, int_to_tile(floor_cells[i]), 0)
#		print(cell)
#		print("Index: %s, Tile: %s, Pos: %s" % [index,int_to_tile(cells[index]), cell])

func int_to_tile(index: int) -> Vector2i:
	match index:
		WATER:
			return(Vector2i(0,0))
		SAND:
			return(Vector2i(1,0))
		DIRT:
			return(Vector2i(2,0))
		GRASS:
			return(Vector2i(3,0))
		SNOW:
			return(Vector2i(3,1))
	return Vector2i(0,0)

#func modify_cell(layer: int, cell: Vector2i, tile: int) -> void:
#	var index: int = cell.x + (32 * cell.y)
#	var tile_entry: int = index + (2 * index)
	
