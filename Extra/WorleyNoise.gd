class_name WorleyNoise
extends Resource

@export var size: Vector2i = Vector2i(256, 256)
@export var max_points: int = 50

var noise_texture: Image

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var points: PackedVector2Array = []

func _init(s: int, p: int) -> void:
	rng.seed = s
	max_points = p
	noise_texture = generate_noise()

func generate_points():
	for i in max_points:
		points.append(Vector2(rng.randi_range(0, size.x), rng.randi_range(0, size.y)))

func generate_noise() -> Image:
	generate_points()
	var img: Image = Image.new()
	img.create(size.x, size.y, false, Image.FORMAT_RGBAH)
	for x in size.x:
		for y in size.y:
			
			var distances: PackedFloat32Array =  []
			for i in points.size():
				var dist: float = Vector2(x, y).distance_to(points[i])
				distances.append(dist)
			
			distances.sort()
			var n: int = 0
			var noise: float = range_lerp(distances[n], 0, size.x/4, 0.0, 1.0)
			img.set_pixel(x, y, Color(noise, noise, noise, 1))
	return img

	
func get_noise(cell: Vector2i) -> float:
	cell.x = cell.x % size.x
	cell.y = cell.y % size.y
	return noise_texture.get_pixelv(cell).r
