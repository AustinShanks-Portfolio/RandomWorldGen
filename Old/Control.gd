extends Control

@onready var l: LineEdit = $Panel/MarginContainer/VBoxContainer/LHBox/LineEdit
@onready var l2: LineEdit = $Panel/MarginContainer/VBoxContainer/LHBox/LineEdit2
@onready var l3: LineEdit = $Panel/MarginContainer/VBoxContainer/LHBox/LineEdit3

@onready var o: LineEdit = $Panel/MarginContainer/VBoxContainer/OHBox/LineEdit
@onready var o2: LineEdit = $Panel/MarginContainer/VBoxContainer/OHBox/LineEdit2
@onready var o3: LineEdit = $Panel/MarginContainer/VBoxContainer/OHBox/LineEdit3

@onready var p: LineEdit = $Panel/MarginContainer/VBoxContainer/PHBox/LineEdit
@onready var p2: LineEdit = $Panel/MarginContainer/VBoxContainer/PHBox/LineEdit2
@onready var p3: LineEdit = $Panel/MarginContainer/VBoxContainer/PHBox/LineEdit3

@onready var per: LineEdit = $Panel/MarginContainer/VBoxContainer/PerHBox/LineEdit
@onready var per2: LineEdit = $Panel/MarginContainer/VBoxContainer/PerHBox/LineEdit2
@onready var per3: LineEdit = $Panel/MarginContainer/VBoxContainer/PerHBox/LineEdit3

@onready var fps: Label = $Panel/MarginContainer/VBoxContainer/FPS

@onready var f: OptionButton = $Panel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/From
@onready var t: OptionButton = $Panel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/To
@onready var n: OptionButton = $Panel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Neighbor
@onready var num: LineEdit = $Panel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer2/Num
@onready var c: LineEdit = $Panel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer2/Chance
@onready var r: LineEdit = $Panel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer2/Repeat

func _ready() -> void:
	for i in Tile:
		f.add_item(i)
		t.add_item(i)
		n.add_item(i)

func _process(_delta: float) -> void:
	fps.text = str("FPS: %s" % [Engine.get_frames_per_second()])

func _on_Button_pressed():
	var array = [
		l.text.to_float(), 
		l2.text.to_float(),
		l3.text.to_float(),
		
		o.text.to_float(),
		o2.text.to_float(),
		o3.text.to_float(),
		
		p.text.to_float(),
		p2.text.to_float(),
		p3.text.to_float(),
		
		per.text.to_float(),
		per2.text.to_float(),
		per3.text.to_float(),
	]
	Events.emit_signal("regen", array)

var Tile: Dictionary = {
	"Any": Vector2i(-1, -1),
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

func _on_Button2_pressed():
	var from: Vector2i = Tile[f.text]
	var to: Vector2i = Tile[t.text]
	var neighbor: Vector2i = Tile[n.text]
	var number: int = num.text.to_int()
	var chance: float = c.text.to_float()
	var repeat: int = r.text.to_int()
	print(from)
	print("Sending: %s %s %s %s %s %s" % [from, to, neighbor, number, chance, repeat])
	Events.emit_signal("ca", from, to, neighbor, number, chance, repeat)
