extends Control

func _unhandled_input(event):
	if event.is_action_pressed("SimPanel"):
		visible = !visible

func _on_Exit_pressed():
	visible = false

func _on_Button_pressed():
	Events.emit_signal("Generate")
