extends VehicleBody3D

@export var speed = 10

# Consider using metadata to control the car's AI

# Keep track of whether car is in left lane or not.
@export var inLeft = true
# Keep track of whether left lane is open or not
var leftOpen = false
# Keep track of whether right lane is open or not
var rightOpen = false

func _physics_process(delta):
	global_position.z -= speed * delta 


# This function will check the front area of car.
# If car is detected, then it will merge lanes.
# Lane merging will depend on inLeft variable
# if inLeft is true, then car merges to left lane
# Otherwise, it will merge to right lane
func _on_check_front_area_entered(area):
	#print(area.get_parent().name)
	# laneShift will vary based on the car's rotation.
	var laneShift = 5 
	# move car to the right
	if inLeft and area.is_in_group("CarNPC") and not area.get_parent().name == "RedCar":
		print("We detected car NPC")
		var tween = create_tween()
		#var newPosition = Vector3(global_position.x + 5, global_position.y, global_position.z)
		tween.tween_property(self, "global_position:x", global_position.x + laneShift, 3)
	#pass # Replace with function body.
