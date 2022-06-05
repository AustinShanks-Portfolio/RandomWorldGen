extends CharacterBody2D

var d_input: Vector2 = Vector2.ZERO
@export var speed: float = 960.0

func _ready():
	pass
	
func _physics_process(_delta: float) -> void:
	d_input = Input.get_vector("left","right","up","down").snapped(Vector2(1,1)).normalized()
	velocity = d_input * speed
	move_and_slide()

func _unhandled_input(event) -> void:
	if event.is_action_pressed("click"):
		Events.emit_signal("mod_terrain", get_global_mouse_position())
