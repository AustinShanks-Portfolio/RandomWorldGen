extends Node

var PCG_Settings: Dictionary = {
	"seed": 0,
	"size": 256,
	"elevation": {"lacunarity": 3, "octaves": 5, "period": 128.0, "persistence": 0.35},
	"moisture": {"lacunarity": 3, "octaves": 9, "period": 128.0, "persistence": 0.5},
	"temperture": {"lacunarity": 3, "octaves": 9, "period": 256.0, "persistence": 0.25},
	"dry": 0.45,
	"wet": 0.55,
	"cold": 0.3,
	"hot": 0.6,
	"ocean": 0.4,
	"mountain": 0.6,
	"peak": 0.7,
}

var Tiles: Dictionary = {
	"Any": Vector2i(-1, -1),
	"Ocean": Vector2i(0,0),
	"Water": Vector2i(1,0),
	"Bedrock": Vector2i(2,0),
	"Stone": Vector2i(3,0),
	"Dirt": Vector2i(4,0),
	"Lava": Vector2i(5,0),
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

var Inventory_Size: int = 40
