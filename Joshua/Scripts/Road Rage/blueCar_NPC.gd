extends VehicleBody3D

@export var speed = 0

func _physics_process(delta):
	global_position.z -= speed * delta 

# When you collide into this car, your car is deleted.
func _on_area_3d_area_entered(area):
	if (area.get_parent().name == "Player" or not area.get_parent().name == "BodyArea"): return
	area.get_parent().queue_free()
