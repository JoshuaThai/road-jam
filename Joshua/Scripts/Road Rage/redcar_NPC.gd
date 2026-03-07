extends VehicleBody3D

@export var speed = 10
@export var direction = 1
var orgSpeed = speed

# hard-coded left and right lane position ( Can be changed by car spawner)
@export var rightPos = 15.0
@export var leftPos = 10.0

# Keep track of whether car is in left lane or not.
@export var inLeft = false
# Keep track of whether left lane is open or not
var leftOpen = true
# Keep track of whether right lane is open or not
var rightOpen = true
# Keep track of whether front lane is open or not
var frontOpen = true
# Keep track of Merging
var isMerging = false

# Keep of if police is near car and merge into a different lane.
var policeNear = false

#var tween

func _ready():
	var selectedSpeed = randi_range(10, 55)
	speed = selectedSpeed
	orgSpeed = speed
	#self.set_meta("Speed", selectedSpeed)
	#self.set_meta("Org Speed", selectedSpeed)
	
func _on_merging_cooldown_timeout():
	isMerging = false
	
func _determine_tween_time(speed):
	if speed < 20 and speed >= 10:
		return 1.5
	if speed < 38 and speed >= 20:
		return 1
	return 0.5
	
func merge():
	#print("Car should be merging")
	print("leftOpen: ", leftOpen)
	var laneShift = 5
#	Move from right lane to left lane (if left lane is open)
	if(not inLeft and leftOpen):
		isMerging = true
		var tween = create_tween()
		var time = _determine_tween_time(speed)
		tween.tween_property(self, "global_position:x", global_position.x - (laneShift * direction), time)
		#$MergingCooldown.start()
		await tween.finished
		speed = orgSpeed
		inLeft = true
		isMerging = false
#	Move from right lane to left lane (if left lane is not open)
#	Reduce speed until you can finally merge.
	if(not inLeft and not leftOpen):
		speed -= 5
		speed = clamp(speed, 0, 55)
		
	#	Move from left lane to right lane (if right lane is open)
	if(inLeft and rightOpen):
		isMerging = true
		var tween = create_tween()
		var time = _determine_tween_time(speed)
		tween.tween_property(self, "global_position:x", global_position.x + (laneShift * direction), time)
		#$MergingCooldown.start()
		await tween.finished
		inLeft = false
		speed = orgSpeed
		isMerging = false
#	Slow car down until it can merge to right lane.
	if(inLeft and not rightOpen):
		speed -= 5
		speed = clamp(speed, 0, 55)
	#await tween.finished
	#isMerging = false

func _physics_process(delta):
	global_position.z -= speed * delta * direction
#	NPC will only attempt merge lane if there is a car in front of them.
	if $FrontRayCast3D.is_colliding():
		var collider = $FrontRayCast3D.get_collider()
		#print("Hit:", collider.name)
#		If car detects a car NPC, perform merge.
		if collider and collider.is_in_group("CarNPC") and not isMerging:
			merge()
#	CHECK IF RIGHT LANE IS OPEN
	if $RightRayCast3D.is_colliding():
		var collider = $RightRayCast3D.get_collider()
#		If car detects a car NPC, perform merge.
		if collider and collider.is_in_group("CarNPC"):
			rightOpen = false
	elif not $RightRayCast3D.is_colliding():
		rightOpen = true
#	CHECK IF LEFT LANE IS OPEN
	if $LeftRayCast3D.is_colliding():
		var collider = $LeftRayCast3D.get_collider()
		#print("Objects to left: ", collider)
		#print("On left: ", collider.name)
#		If car detects a car NPC, perform merge.
		if collider and collider.is_in_group("CarNPC"):
			leftOpen = false
	elif not $LeftRayCast3D.is_colliding():
		leftOpen = true
	if $BackRayCast3D.is_colliding():
		var collider = $BackRayCast3D.get_collider()
		if collider and collider.is_in_group("CarNPC") and collider.get_parent().is_in_group("PoliceCar"):
			merge()
			#policeNear = true
	#elif not $BackRayCast3D.is_colliding():
		#policeNear = false
	
	
func _on_despawn_timer_timeout():
	queue_free()
