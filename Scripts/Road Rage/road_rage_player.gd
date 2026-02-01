extends Camera3D
# MOVE THE CAMERA WHEN PLAYER IS IN CAR IN ROAD RAGE LEVEL

# Hide cursor in game
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
# Player will rotate with mouse motion!
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.5
#		Prevents players from rotating 360 view
		rotation_degrees.y = clamp(
			rotation_degrees.y, -45.0, 45.0
		)
		rotation_degrees.x -= event.relative.y * 0.2
#		Prevent players from fipping the view.
		rotation_degrees.x = clamp(
			rotation_degrees.x, -80.0, 80.0
		)
#		Show cursor when player clicks escape key.
	elif event.is_action_pressed("ui_cancel"): 
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
