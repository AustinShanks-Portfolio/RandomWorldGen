extends TileMap

@export var size: Vector2i = Vector2i(512, 512)
var worley: WorleyNoise = WorleyNoise.new(randi(), 20)

var Tile: Dictionary = {
	"Ocean": Vector2i(0,0),
	"Water": Vector2i(1,0),
	"Bedrock": Vector2i(2,0),
	"Stone": Vector2i(3,0),
	"Dirt": Vector2i(4,0),
	"Lava": Vector2i(5,1),
	"Grass": Vector2i(0,1),
	"Sand": Vector2i(1,1),
	"Snow": Vector2i(2,1),
	"Clay": Vector2i(3,1),
	"Mud": Vector2i(4,1),
	"Basalt": Vector2i(5,1),
	"Forest": Vector2i(0,2),
	"Oasis": Vector2i(1,2),
	"Highland": Vector2i(2,2),
	"Mountain": Vector2i(3,2),
	"Peak": Vector2i(4,2),
}


func _ready():
	for x in size.x:
		for y in size.y:
#			var e: float = worley.get_noise(Vector2i(x, y))
#			print(e)
			set_cell(0, Vector2i(x, y), 0, noise_tile(Vector2i(x, y)), 0)

func noise_tile(cell: Vector2i) -> Vector2i:
	var e: float = worley.get_noise(cell)
	if e <= water_level:
		return Tile.Ocean
	elif e > water_level and e <= mountain_level:
		return Tile.Dirt
	else:
		return Tile.Mountain

var water_level: float = 0.35
var mountain_level: float = 0.65
