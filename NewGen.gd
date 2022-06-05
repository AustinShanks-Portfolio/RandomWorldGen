extends TileMap

@export var elevation: FastNoiseLite = FastNoiseLite.new()
@export var moisture: FastNoiseLite = FastNoiseLite.new()
@export var tempeture: FastNoiseLite = FastNoiseLite.new()

var north_pole: int
var south_pole: int
var equator: int

var pole_weight: float = -0.2
var equator_weight: float = 0.2

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	Events.connect("Generate", self.generate, [])
	Events.connect("ca", self.cellular_automata, [])
	set("layer_0/tile_data", [0, 65536, 0, 1, 65536, 0])
	force_update(0)
	generate()

func generate() -> void:
	var map_size: int = G.PCG_Settings.size
	setup_noise()
	var time: int = Time.get_ticks_msec()
	var old_progress: float = 0
	randomize()
	var size: int = map_size * map_size
#	print(size)
#	var tile_data: PackedInt32Array
#	var tile_x: int = 0
#	var tile_y: int = 0
	for i in size:
		var progress = 100 * (i / float(size))
#		var coord: Vector2i = Vector2i(i / map_size, i % map_size)
#		var compressed_coord: int = coord.x + (65536 * coord.y)
#		tile_data.append(compressed_coord)
#		tile_data.append(tile_x)
#		tile_data.append(tile_y)
		generate_elevation(Vector2i(i / map_size, i % map_size))
		if floor(progress) > old_progress:
			print("Generating Elevation: %s%% Complete" % [floor(progress)])
			old_progress = floor(progress)
#	set("layer_0/tile_data", tile_data)
#	force_update(0)
	
	for i in size:
		generate_biome(Vector2i(i / G.PCG_Settings.size, i % G.PCG_Settings.size))

#	replace_cell(Tile.Sand, Tile.Clay, 0.0002)
#	blue_noise(Tile.Sand, Tile.Clay, 0.38)
	cellular_automata(G.Tiles.Sand, G.Tiles.Clay, G.Tiles.Clay, 1, 0.25, 10)
	cellular_automata(G.Tiles.Sand, G.Tiles.Clay, G.Tiles.Clay, 6, 1, 5)
	cellular_automata(G.Tiles.Clay, G.Tiles.Sand, G.Tiles.Sand, 5, 1, 10)
	print("Time: %sms, RAM: %s" % [(Time.get_ticks_msec() - time), String.humanize_size(OS.get_static_memory_usage())])
	

func setup_noise() -> void:
	rng.seed = G.PCG_Settings.seed
#	elevation.lacunarity = G.PCG_Settings.elevation.lacunarity
#	elevation.octaves = G.PCG_Settings.elevation.octaves
#	elevation.period = G.PCG_Settings.elevation.period
#	elevation.persistence = G.PCG_Settings.elevation.persistence
	moisture.seed = rng.randi()
#	moisture.lacunarity = G.PCG_Settings.moisture.lacunarity
#	moisture.octaves = G.PCG_Settings.moisture.octaves
#	moisture.period = G.PCG_Settings.moisture.period
#	moisture.persistence = G.PCG_Settings.moisture.persistence
	tempeture.seed = rng.randi()
#	tempeture.lacunarity = G.PCG_Settings.temperture.lacunarity
#	tempeture.octaves = G.PCG_Settings.temperture.octaves
#	tempeture.period = G.PCG_Settings.temperture.period
#	tempeture.persistence = G.PCG_Settings.temperture.persistence

func generate_elevation(cell: Vector2i) -> void:
	set_cell(0, cell, 0, elevation_noise(cell), 0)

func generate_biome(cell: Vector2i) -> void:
	if get_cell_atlas_coords(0, cell, false) != G.Tiles.Dirt:
		return
	set_cell(0, cell, 0, biome_noise(cell), 0)


func elevation_noise(cell: Vector2i) -> Vector2i:
	var e: float = elevation.get_noise_2dv(cell) * 0.5 + 0.5
	var t: float = tempeture.get_noise_2dv(cell) * 0.5 + 0.5
	if e <= G.PCG_Settings.ocean:
		return G.Tiles.Ocean
	elif e > G.PCG_Settings.ocean and e <= G.PCG_Settings.mountain:
		return G.Tiles.Dirt
	elif e > G.PCG_Settings.mountain and e <= G.PCG_Settings.peak:
		return G.Tiles.Mountain
	elif e > 0.8:
		if t > G.PCG_Settings.hot:
			return G.Tiles.Lava
		else:
			return G.Tiles.Water
	else:
		return G.Tiles.Peak


func biome_noise(cell: Vector2i) -> Vector2i:
	var m: float = moisture.get_noise_2dv(cell) * 0.5 + 0.5
	var t: float = tempeture.get_noise_2dv(cell) * 0.5 + 0.5
	if m <= G.PCG_Settings.dry:
		if t <= G.PCG_Settings.cold:
			return G.Tiles.Oasis
		if t >= G.PCG_Settings.hot:
			return G.Tiles.Sand
		else:
			return G.Tiles.Sand
	elif m >= G.PCG_Settings.wet:
		if t <= G.PCG_Settings.cold:
			return G.Tiles.Snow
		if t >= G.PCG_Settings.hot:
			return G.Tiles.Mud
		else:
			return G.Tiles.Forest
	return G.Tiles.Grass

func cellular_automata(from: Vector2i, to: Vector2i, neighbor: Vector2i, num_neighbors: int = 1, chance: float = 1.0, repeat: int = 1) -> void:
	print("Doing CA %s, %s, %s, %s, %s, %s" % [from, to, neighbor, num_neighbors, chance, repeat])
	for i in repeat:
		var changes: PackedVector2Array = []
		for cell in get_used_cells(0):
			if from != Vector2i(-1, -1) and get_cell_atlas_coords(0, cell, false) != from:
				continue
			if rng.randf() > chance:
				continue
			if get_neightbors(cell, neighbor) >= num_neighbors:
				changes.append(cell)
		for cell in changes:
			set_cell(0, cell, 0, to, 0)

var directions = [
	Vector2i( 0, 1), #N
	Vector2i( 1, 1), #NE
	Vector2i( 1, 0), #E
	Vector2i(-1, 1), #SE
	Vector2i(-1, 0), #S
	Vector2i(-1,-1), #SW
	Vector2i( 0,-1), #W
	Vector2i( 1,-1), #NW
]

func get_neightbors(coords: Vector2i, tile: Vector2i) -> int:
	var count: int = 0
	for i in directions:
		if get_cell_atlas_coords(0, coords + i, false) == tile or tile == Vector2i(-1, -1):
			count += 1
	return count
