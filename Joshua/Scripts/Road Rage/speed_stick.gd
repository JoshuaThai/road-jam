extends ColorRect


func _physics_process(delta):
	var speed = %Camera3D.get_parent().SPEED
	#print("Speed Detected by Speedometer: ", speed)
	rotation_degrees = -215 + (speed * 1.125)
