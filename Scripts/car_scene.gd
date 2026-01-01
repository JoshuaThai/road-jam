extends Node3D

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("ui_cancel"): 
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("ui_accept"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
