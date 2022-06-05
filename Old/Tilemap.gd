extends Node2D

@export var Seed := 123456890
@export var world_size: Vector2i = Vector2i(10, 10)
@export var chunk_size: int = 32
@export var tile_size: int = 16
var size: int = chunk_size * tile_size

var elevation: OpenSimplexNoise = OpenSimplexNoise.new()
var moisture: OpenSimplexNoise = OpenSimplexNoise.new()

enum {WATER, SAND, DIRT, GRASS, SNOW}

var map: Dictionary = {}

@export var ocean: float = -0.2
@export var sand: float = -0.1
@export var dirt: float = 0.0
@export var grass: float = 0.2
@export var snow: float = 0.3

#
# X,Y: [Floor, Object[], Object Health, Roof]

var time: int = 0

func _ready() -> void:
	Events.connect("mod_terrain", self.mod_terrain, [])
#	print(tiles.sand)
	time = Time.get_ticks_msec()
	
	for i in world_size.x * world_size.y:
		print("Creating Chunk %s out of %s" % [i, world_size.x * world_size.y])
		generate_chunk(Vector2i(i / world_size.y, i % world_size.y))
	
	print((Time.get_ticks_msec() - time))
	print(String.humanize_size(OS.get_static_memory_usage()))
#	Events.connect("regen", self.generate, [])
#	generate(4.0, 9, 512.0, 0.25)
#	var array: PackedInt32Array = [88, 89, 90, 14, 24, 34, 64, 54, 65, 889]
#	for i in 4:
#		print(i+(2*i))
#		print(array[i+(2*i)])

func mod_terrain(coords: Vector2) -> void:
	var key: Vector2i = (coords/size).floor()
	var chunk: Chunk = get_node_or_null(str("%s_%s" % [key.x, key.y]))
	var cell: Vector2i = (coords/tile_size).floor()-Vector2(chunk_size*key.x,chunk_size*key.y)
	if chunk:
		chunk.modify_cell(0, cell, 0)
#	test.set_cell(0, cell, 0, Vector2i(3, 0), 0)

func setup_noise(l: float, o: int, p: float, per: float) -> void:
	elevation.lacunarity = l
	elevation.octaves = o
	elevation.period = p
	elevation.persistence = per

var chunk_asset: PackedScene = preload("res://Scenes/Chunks/Chunk.tscn")

func generate_chunk(coords: Vector2i) -> void:
		var new_chunk: Chunk = chunk_asset2
		new_chunk.name = str("%s_%s" % [coords.x, coords.y])
		new_chunk.position = Vector2(coords.x * size, coords.y * size)
		for i in chunk_size * chunk_size:
			var cell: Vector2i = Vector2i(i % 32, i / 32) + coords * chunk_size
			new_chunk.floor_cells.append(noise_to_tile(cell))
			new_chunk.object_cells.append(0)
			new_chunk.roof_cells.append(0)
		new_chunk.render()
		add_child(new_chunk)
		
	

func noise_to_tile(coords: Vector2i) -> int:
	var e: float = elevation.get_noise_2dv(coords)
	var _m: float = moisture.get_noise_2dv(coords)
	if e <= ocean:
		return WATER
	elif e > ocean and e <= sand:
		return SAND
	elif e > sand and e <= dirt:
		return DIRT
	elif e > dirt and e <= snow:
		return GRASS
	elif e > snow:
		return SNOW
	else:
		return -1

#func generate(l: float, o: int, p: float, per: float) -> void:
#	setup_noise(l, o, p, per)
#	time = Time.get_ticks_msec()
#	for x in world_size.x:
#		for y in world_size.y:
#			set_cell(0, Vector2(x, y), 0, noise_to_tile(Vector2(x, y)), 0)
#	print((Time.get_ticks_msec() - time))
#	print(String.humanize_size(OS.get_static_memory_usage()))
