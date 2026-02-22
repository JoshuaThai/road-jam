extends VehicleBody3D

@export var speed = 0

func _physics_process(delta):
	global_position.z -= speed * delta 
