extends HBoxContainer

@onready var seed_box: LineEdit = $LineEdit
@onready var size_box: LineEdit = $LineEdit2

func _ready() -> void:
	seed_box.text = str(G.PCG_Settings.seed)
	size_box.text = str(G.PCG_Settings.size)

func _on_LineEdit_text_submitted(new_text: String) -> void:
	G.PCG_Settings.seed = new_text.to_int()

func _on_LineEdit2_text_submitted(new_text: String) -> void:
	G.PCG_Settings.size = new_text.to_int()
