extends VBoxContainer

@onready var el: LineEdit = $GridContainer/EL
@onready var eo: LineEdit = $GridContainer/EO
@onready var ef: LineEdit = $GridContainer/EF
@onready var ep: LineEdit = $GridContainer/EP

@onready var ml: LineEdit = $GridContainer/ML
@onready var mo: LineEdit = $GridContainer/MO
@onready var mf: LineEdit = $GridContainer/MF
@onready var mp: LineEdit = $GridContainer/MP

@onready var tl: LineEdit = $GridContainer/TL
@onready var to: LineEdit = $GridContainer/TO
@onready var tf: LineEdit = $GridContainer/TF
@onready var tp: LineEdit = $GridContainer/TP

func _ready() -> void:
	update_display()
	
func update_display() -> void:
	el.text = str(G.PCG_Settings.elevation.lacunarity)
	eo.text = str(G.PCG_Settings.elevation.octaves)
	ef.text = str(G.PCG_Settings.elevation.period)
	ep.text = str(G.PCG_Settings.elevation.persistence)

	ml.text = str(G.PCG_Settings.moisture.lacunarity)
	mo.text = str(G.PCG_Settings.moisture.octaves)
	mf.text = str(G.PCG_Settings.moisture.period)
	mp.text = str(G.PCG_Settings.moisture.persistence)
	
	tl.text = str(G.PCG_Settings.temperture.lacunarity)
	to.text = str(G.PCG_Settings.temperture.octaves)
	tf.text = str(G.PCG_Settings.temperture.period)
	tp.text = str(G.PCG_Settings.temperture.persistence)




func _on_EL_text_changed(new_text: String) -> void:
	G.PCG_Settings.elevation.lacunarity = new_text.to_float()
func _on_EO_text_changed(new_text: String) -> void:
	G.PCG_Settings.elevation.octaves = clamp(new_text.to_int(), 1, 9)
func _on_EF_text_changed(new_text: String) -> void:
	G.PCG_Settings.elevation.period = new_text.to_float()
func _on_EP_text_changed(new_text: String) -> void:
	G.PCG_Settings.elevation.persistence = new_text.to_float()

func _on_ML_text_changed(new_text: String) -> void:
	G.PCG_Settings.moisture.lacunarity = new_text.to_float()
func _on_MO_text_changed(new_text: String) -> void:
	G.PCG_Settings.moisture.octaves = clamp(new_text.to_int(), 1, 9)
func _on_MF_text_changed(new_text: String) -> void:
	G.PCG_Settings.moisture.period = new_text.to_float()
func _on_MP_text_changed(new_text: String) -> void:
	G.PCG_Settings.moisture.persistence = new_text.to_float()

func _on_TL_text_changed(new_text: String) -> void:
	G.PCG_Settings.temperture.lacunarity = new_text.to_float()
func _on_TO_text_changed(new_text: String) -> void:
	G.PCG_Settings.temperture.octaves = clamp(new_text.to_int(), 1, 9)
func _on_TF_text_changed(new_text: String) -> void:
	G.PCG_Settings.temperture.period = new_text.to_float()
func _on_TP_text_changed(new_text: String) -> void:
	G.PCG_Settings.temperture.persistence = new_text.to_float()
