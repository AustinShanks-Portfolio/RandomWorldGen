extends Camera2D

func _input(event):
	if event.is_action_pressed("plus"):
		zoom = zoom / 2
	if event.is_action_pressed("minus"):
		if zoom != Vector2(32, 32):
			zoom += Vector2(1, 1)
