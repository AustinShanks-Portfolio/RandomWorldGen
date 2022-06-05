extends VBoxContainer

var num: int = 0
var c: float = 1.0
var l: int = 1

@onready var from_tile: OptionButton = $HB1/From
@onready var to_tile: OptionButton = $HB1/To
@onready var neighbor_tile: OptionButton = $HB1/Neighbor

@onready var chance_slider: HSlider = $HB2/ChanceSlider
@onready var chance_box: SpinBox = $HB2/ChanceBox

func _ready():
	for i in G.Tiles:
		from_tile.add_item(i)
		to_tile.add_item(i)
		neighbor_tile.add_item(i)
	update_display()

func update_display() -> void:
	chance_slider.value = c
	chance_box.value = c

func _on_ChanceSlider_value_changed(value):
	c = value
	update_display()

func _on_ChanceBox_value_changed(value):
	c = value
	update_display()

func _on_Spinbox_value_changed(value):
	l = value

func _on_Count_value_changed(value):
	num = value

func _on_Button_pressed():
	var from: Vector2i = G.Tiles[from_tile.text]
	var to: Vector2i = G.Tiles[to_tile.text]
	var neighbor: Vector2i = G.Tiles[neighbor_tile.text]
	print("Sending: %s %s %s %s %s %s" % [from, to, neighbor, num, c, l])
	Events.emit_signal("ca", from, to, neighbor, num, c, l)


