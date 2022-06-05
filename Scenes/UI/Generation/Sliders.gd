extends VBoxContainer

@onready var dry_slider: HSlider = $Dry/HSlider
@onready var wet_slider: HSlider = $Wet/HSlider
@onready var cold_slider: HSlider = $Cold/HSlider
@onready var hot_slider: HSlider = $Hot/HSlider
@onready var ocean_slider: HSlider = $Ocean/HSlider
@onready var mountain_slider: HSlider = $Mountain/HSlider
@onready var peak_slider: HSlider = $Peak/HSlider

@onready var dry_box: LineEdit = $Dry/Box
@onready var wet_box: LineEdit = $Wet/Box
@onready var cold_box: LineEdit = $Cold/Box
@onready var hot_box: LineEdit = $Hot/Box
@onready var ocean_box: LineEdit = $Ocean/Box
@onready var mountain_box: LineEdit = $Mountain/Box
@onready var peak_box: LineEdit = $Peak/Box

func _ready():
	update_display()
	
func update_display() -> void:
	var values = G.PCG_Settings
	dry_slider.value = values.dry
	dry_box.text = str(values.dry)
	wet_slider.value = values.wet
	wet_box.text = str(values.wet)
	cold_slider.value = values.cold
	cold_box.text = str(values.cold)
	hot_slider.value = values.hot
	hot_box.text = str(values.hot)
	ocean_slider.value = values.ocean
	ocean_box.text = str(values.ocean)
	mountain_slider.value = values.mountain
	mountain_box.text = str(values.mountain)
	peak_slider.value = values.peak
	peak_box.text = str(values.peak)

func update_value(value: float, type: String) -> void:
	match type:
		"dry":
			G.PCG_Settings.dry = value
		"wet":
			G.PCG_Settings.wet = value
		"cold":
			G.PCG_Settings.cold = value
		"hot":
			G.PCG_Settings.hot = value
		"ocean":
			G.PCG_Settings.ocean = value
		"mountain":
			G.PCG_Settings.mountain = value
		"peak":
			G.PCG_Settings.peak = value
	update_display()
	
func _on_Box_text_submitted(new_text, extra_arg_0):
	var value: float = clamp(new_text.to_float(), 0.0, 1.0)
	update_value(value, extra_arg_0)

func _on_HSlider_value_changed(value, extra_arg_0):
	update_value(value, extra_arg_0)
