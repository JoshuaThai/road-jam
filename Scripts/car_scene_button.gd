extends Button

func _on_pressed():
	get_parent().visible = false
	get_tree().paused = false
	if Global.drunk:
		%DrunkVision.visible = true
	%PointsUI.visible = true

func _physics_process(delta):
	if Input.is_key_pressed(Key.KEY_1):
		get_parent().visible = false
		get_tree().paused = false
		if Global.drunk:
			%DrunkVision.visible = true
		%PointsUI.visible = true
