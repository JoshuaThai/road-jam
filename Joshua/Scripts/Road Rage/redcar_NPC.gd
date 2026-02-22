extends VehicleBody3D

#@export var speed = 10

# Consider using metadata to control the car's AI

# Keep track of whether car is in left lane or not.
#@export var inLeft = true
# Keep track of whether left lane is open or not
#var leftOpen = false
# Keep track of whether right lane is open or not
#var rightOpen = false

func _ready():
	self.set_meta("Speed", randi_range(10, 55))

func _physics_process(delta):
	global_position.z -= self.get_meta("Speed") * delta 

func _determine_tween_time(speed):
	if speed < 20 and speed >= 10:
		return 3
	if speed < 38 and speed >= 20:
		return 2
	return 1


# This function will check the front area of car.
# If car is detected, then it will merge lanes.
# Lane merging will depend on inLeft variable
# if inLeft is true, then car merges to left lane
# Otherwise, it will merge to right lane
func _on_check_front_area_entered(area):
	#print(area.get_parent().name)
	# laneShift will vary based on the car's rotation.
	var laneShift = 5 
	# move car to the right (if coming from the direction that is front of the car).
	if self.get_meta("In Left") and area.is_in_group("CarNPC") and not area.get_parent().name == self:
		# We must always check if right lane is open.
		# If right lane is not open and car isn't merging, car should slow down.
		if not self.get_meta("Right Open") and not self.get_meta("Merging"): 
			self.set_meta("Speed", self.get_meta("Speed") - 10)
#		.......
		#print("We detected car NPC")
		self.set_meta("Merging", true)
		self.set_meta("In Left", false)
		var tween = create_tween()
		var time = _determine_tween_time(self.get_meta("Speed"))
		tween.tween_property(self, "global_position:x", area.global_position.x + laneShift, time)
		await tween.finished
		self.set_meta("Merging", false)
		
		
	# move car to the left (if coming from the direction that is front of the car).
	if not self.get_meta("In Left") and area.is_in_group("CarNPC") and not area.get_parent() == self:
		# We must always check if left lane is open.
		# If left lane is not open and car isn't merging, car should slow down.
#		Current Issue: Speed is being reduced due to the check areas colliding with the car we are merging from
#		Potential Solution: Maybe we should keep of the car we are merging from, so this isn't triggered.
		if not self.get_meta("Left Open") and not self.get_meta("Merging"): 
			print("Speed reduced")
			self.set_meta("Speed", self.get_meta("Speed") - 10)
#		.....
		self.set_meta("Merging", true)
		self.set_meta("In Left", true)
		var tween = create_tween()
		var time = _determine_tween_time(self.get_meta("Speed"))
		tween.tween_property(self, "global_position:x", area.global_position.x - laneShift, time)
		await tween.finished
		self.set_meta("Merging", false)
		
		

# Something was detected in left lane
func _on_check_left_area_entered(area):
	if not area.is_in_group("CarNPC") and self.get_meta("Merging"): return
	print("Something in left lane")
	self.set_meta("Left Open", false)
	
# Nothing in left lane
func _on_check_left_area_exited(area):
	if not area.is_in_group("CarNPC") and self.get_meta("Merging"): return
	print("Nothing in left lane")
	self.set_meta("Left Open", true)
	
func _on_check_right_area_entered(area):
	if not area.is_in_group("CarNPC") and self.get_meta("Merging"): return
	print("Something in right lane")
	self.set_meta("Right Open", false)

func _on_check_right_area_exited(area):
	if not area.is_in_group("CarNPC") and self.get_meta("Merging"): return
	print("Nothing in right lane")
	self.set_meta("Right Open", true)
