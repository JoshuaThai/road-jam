extends VehicleBody3D

const SPEED = 40

# Car variables
# Prevent the car from moving at the start
var carStarted = false
# Keep track of when the car is accelerating
var isAccelerating = false
# Keep track of when the car is merging
var isMerging = false
# Make sure the car can only merge between the left and right lane
var inLeft = false

var speedOffset = 0

@onready var CarAnimations = $CarAnimations
@onready var rear_mirror = $Mirrors/RearViewport/MirrorCamera
@onready var left_mirror = $Mirrors/LeftViewport/MirrorCamera
@onready var right_mirror = $Mirrors/RightViewport/MirrorCamera

@onready var rear_marker = $Mirrors/RearCamMarker
@onready var left_marker = $Mirrors/LeftCamMarker
@onready var right_marker = $Mirrors/RightCamMarker

func _process(_dt):
	rear_mirror.global_transform = rear_marker.global_transform
	left_mirror.global_transform = left_marker.global_transform
	right_mirror.global_transform = right_marker.global_transform

func _physics_process(delta):

		#CarAnimations.play("move_left")
	# When player are clicking w, they are moving forward.
	if (Input.is_key_pressed(Key.KEY_W)):
		if(!carStarted):
			carStarted = true
		speedOffset = 0
		isAccelerating = true
	else:
		isAccelerating = false
	if isAccelerating:
#		YOU CAN ONLY SWITCH LANES WHILE ACCELERATING
		#	If you press q, player switch lanes to left.
		if(Input.is_key_pressed(Key.KEY_Q) and not isMerging and not inLeft):
			inLeft = true
			isMerging = true
			var tween = create_tween()
			#var newPosition = Vector3(global_position.x + 5, global_position.y, global_position.z)
			tween.tween_property(self, "global_position:x", global_position.x + 5, 1)
			isMerging = false
			
#			If you press E, player switch lane to the right.
		if(Input.is_key_pressed(Key.KEY_E) and not isMerging and inLeft):
			inLeft = false
			isMerging = true
			var tween = create_tween()
			#var newPosition = Vector3(global_position.x + 5, global_position.y, global_position.z)
			tween.tween_property(self, "global_position:x", global_position.x - 5, 1)
			isMerging = false
		global_position.z += SPEED * delta
	else:
		if(!carStarted): return
#		Player should gradually slow down if not accelerating.
		var speed = (SPEED * delta) - speedOffset
		speedOffset += 0.005
		if speed <= 0: 
			global_position.z += 0
		else:
			global_position.z += speed



func _on_area_3d_area_entered(area):
	print(area.name)
	if area.name == "GenerateGround":
		var ground = load("res://Scenes/ProceduralGeneration/ground.tscn").instantiate()
#		We need to access ground size to calculate how to do proceduaral generation for road rage.
		print(ground.get_node("ActualGround").size)
		var offset = ground.get_node("ActualGround").size.z
		ground.global_position.z = area.get_parent().global_position.z + offset
		get_tree().root.add_child(ground)
		print("Ground should be generated")
	pass
	
	
	
