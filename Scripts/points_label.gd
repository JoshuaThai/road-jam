extends Label

func _physics_process(delta):
#	We will handle when points hits 0 or goes below it.
	if Global.driving_points <= 0:
		Global.driving_points = 0
		%EndingUI.visible = true
		if Global.drunk:
			%EndingDialogue.emit_signal("endingReceived", "Drunk")
		else:
			%EndingDialogue.emit_signal("endingReceived", "Bad")
		#print("Is this working????")
		get_tree().paused = true
	text = "Points: " + str(Global.driving_points)
