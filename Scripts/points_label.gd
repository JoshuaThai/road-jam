extends Label

func _physics_process(delta):
	text = "Points: " + str(Global.driving_points)
