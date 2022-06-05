class_name GameObject
extends StaticBody2D

@export var max_health: int = 10

var health: int = 0
var selected: bool = false

@onready var bar: Node2D = $HealthDisplay

func _ready() -> void:
	health = max_health
	bar.update_bar(health, max_health)

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			adjust_hp(-1)
		if event.button_index == 2:
			adjust_hp(1)

func adjust_hp(value: int) -> void:
	health += value
	health = clamp(health, 0, max_health)
	bar.update_bar(health, max_health)
	if health < 1:
		queue_free()
