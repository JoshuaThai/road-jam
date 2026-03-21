extends VehicleBody3D

@export var speed = 10.0
@export var direction = 1
@export var orgSpeed = speed
@onready var animationPlayer = $AnimationPlayer

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
# Activate  chase if a car in front of them is wanted.
var foundWanted = false

# Keeps track if car is too close.
var tooClose = false

#var tween

func _ready():
#	Original speed was 30 to 65
	var selectedSpeed = randf_range(20.0, 40.0)
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
	return 0.25
	
func activateSignals(signalName):
	animationPlayer.play(signalName)
	
func merge():
	#print("Car should be merging")
	print("leftOpen: ", leftOpen)
	var laneShift = 5
#	Activate Turn Signals and Put a Wait to ensure car reacts slowly.
	
#	Move from right lane to left lane (if left lane is open)
	if(not inLeft and leftOpen):
		isMerging = true
		if direction == -1:
			activateSignals("Turn Left")
		else:
			activateSignals("Turn Right")
		var tween = create_tween()
		var time = _determine_tween_time(speed)
		tween.tween_property(self, "global_position:x", global_position.x - (laneShift * direction), time)
		#$MergingCooldown.start()
		await get_tree().create_timer(2.0).timeout
		print("ANIMATION SHOULD RESET")
		activateSignals("RESET")
		#speed = orgSpeed
		inLeft = true
		isMerging = false
#	Move from right lane to left lane (if left lane is not open)
#	Reduce speed until you can finally merge.
	if(not inLeft and not leftOpen):
		speed -= 10
		speed = clamp(speed, 0, 65)
		
	#	Move from left lane to right lane (if right lane is open)
	if(inLeft and rightOpen):
		isMerging = true
		if direction == -1:
			activateSignals("Turn Right")
		else:
			activateSignals("Turn Left")
		
		var tween = create_tween()
		var time = _determine_tween_time(speed)
		tween.tween_property(self, "global_position:x", global_position.x + (laneShift * direction), time)
		#$MergingCooldown.start()
		await get_tree().create_timer(2.0).timeout
		print("ANIMATION SHOULD RESET")
		activateSignals("RESET")
		inLeft = false
		#speed = orgSpeed
		isMerging = false
#	Slow car down until it can merge to right lane.
	if(inLeft and not rightOpen):
		speed -= 10
		speed = clamp(speed, 0, 65)
	#await tween.finished
	#isMerging = false

func _physics_process(delta):
	global_position.z -= speed * delta * direction
	#print("SPEED: ", speed)
	if not tooClose:
		speed = orgSpeed
		
	#if tooClose:
		#speed = speed/2
		#print("SPEED: ", speed)
	#else:
		#speed = orgSpeed
#	NPC will only attempt merge lane if there is a car in front of them.
	if $FrontRayCast3D.is_colliding():
		var collider = $FrontRayCast3D.get_collider()
		if collider and self.global_position.distance_to(collider.global_position) < 30:
			tooClose = true
#			Calculate how slow the car should move based on distance from carNPC
#			Car will slow down to the point that it stops when it gets too close to another car.
			if collider.is_in_group("CarNPC"):
				print("WHAT IS IT: ", self.global_position.distance_to(collider.global_position))
				speed = orgSpeed * (self.global_position.distance_to(collider.global_position))/40.0
				speed = clamp(speed, 1, orgSpeed)
		else:
			tooClose = false
		# slow down the car based on the collider distance from the car.
		#print("Hit:", collider.name)
#		If car detects a car NPC, perform merge.
		if collider and collider.is_in_group("CarNPC") and not isMerging:
			merge()
	else:
		speed += 5
		speed = clamp(speed, 30, orgSpeed)
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
	if $LeftBlindSpot.is_colliding():
		var collider = $LeftBlindSpot.get_collider()
		if collider and collider.is_in_group("CarNPC"):
			leftOpen = false
	if $RightBlindSpot.is_colliding():
		var collider = $RightBlindSpot.get_collider()
		if collider and collider.is_in_group("CarNPC"):
			rightOpen = false
	
	
func _on_despawn_timer_timeout():
	("Police car should despawn.")
	queue_free()
