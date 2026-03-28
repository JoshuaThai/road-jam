extends VehicleBody3D

signal policeCalled
signal restartLevel
#const SPEED = 40
var MAX_SPEED = 160
@export var SPEED = 0
# We will use this to adjust brake speed
var speedOffset = 5
var turnOffset = 1

# Car variables
# Prevent the car from moving at the start
var carStarted = false
# Keep track of when the car is accelerating
var isAccelerating = false
# Keep track of when the car is merging
var isMerging = false
# Make sure the car can only merge between the left and right lane
var inLeft = false
# Make sure the car doesn't merge lane repeatedly.
var canMerge = true


var phoneRinging = preload("res://Joshua/Road Rage/Audio/phone-ringing.mp3")
var policeOnWay = preload("res://Joshua/Road Rage/Audio/PoliceOnWay.mp3")

@onready var rear_mirror = $Mirrors/RearViewport/MirrorCamera
@onready var left_mirror = $Mirrors/LeftViewport/MirrorCamera
@onready var right_mirror = $Mirrors/RightViewport/MirrorCamera

@onready var rear_marker = $Mirrors/RearCamMarker
@onready var left_marker = $Mirrors/LeftCamMarker
@onready var right_marker = $Mirrors/RightCamMarker
@onready var frontCar = $FrontCar

func _ready():
	policeCalled.connect(call_police)
	
func call_police():
	$%LevelTimer.paused = true
	Global.policeActivated = true
	$%TimerText.visible = false
	$%PhoneCallAudio.stream = phoneRinging
	$%PhoneCallAudio.play(4.0)
	$AnimationPlayer.play("PhoneCall")
	#if Global.carHealth <= 0: return
	
	await $%PhoneCallAudio.finished
	$%PhoneCallAudio.stream = policeOnWay
	$%PhoneCallAudio.play(0.0)
	#if Global.carHealth <= 0: return
	
	await $%PhoneCallAudio.finished
	
	$PoliceSiren.play()
	$%TimerText.visible = true
	$%PoliceChaseText.visible = true
	$%PoliceChaseTimer.start()
	

func _process(_dt):
	rear_mirror.global_transform = rear_marker.global_transform
	left_mirror.global_transform = left_marker.global_transform
	right_mirror.global_transform = right_marker.global_transform

func _physics_process(delta):
	#print("HEALTH: ", Global.carHealth)
#	When user clicks the screen, the UI disappears
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not Global.roadDodgingStart):
		get_tree().paused = false
		$%Instructions.visible = false
		Global.roadDodgingStart = true
		$LevelTimer.start()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if not Global.roadDodgingStart: return
	
	%ProgressBar.value = Global.carHealth
	if Global.carHealth <= 0: return
	
	if Global.policeActivated:
		$%TimerText.text = "Timer: %d" % $%PoliceChaseTimer.time_left
	else:
		$%TimerText.text = "Timer: %d" % $%LevelTimer.time_left
	if frontCar.is_colliding():
		var collider = frontCar.get_collider()
		#print("COLLIDER: ", collider.name)
#		Destroy car spawn that car gets too close too.
		if(collider and collider.name == "DestroySpawn"):
			collider.get_parent().queue_free()
	#print("Speed: ", SPEED)
#	 Slow car down if moving.
	if (Input.is_key_pressed(Key.KEY_S)):
		if(!carStarted):
			carStarted = true
		if SPEED <= 0:
			SPEED = 0
			speedOffset = 5
			turnOffset = 1
			global_position.z += 0
			return
		SPEED -= 1
		SPEED = clamp(SPEED, 0, MAX_SPEED)
	elif(Input.is_key_pressed(Key.KEY_A)):
		rotate_y((0.15 * turnOffset) * delta)
	elif(Input.is_key_pressed(Key.KEY_D)):
		rotate_y((-0.15 * turnOffset) * delta)

	elif (Input.is_key_pressed(Key.KEY_W)):
		SPEED += 0.15
		SPEED = clamp(SPEED, 0, MAX_SPEED)
		speedOffset -= 0.01
		turnOffset += 0.01
		speedOffset = clamp(speedOffset, 1, 5)
		turnOffset = clamp(turnOffset, 1, 2)
	else:
		SPEED -= 0.05 * speedOffset
		SPEED = clamp(SPEED, 0, MAX_SPEED)
		speedOffset += 0.01
		turnOffset -= 0.01
		speedOffset = clamp(speedOffset, 1, 5)
		turnOffset = clamp(turnOffset, 1, 2)
		if SPEED <= 0: 
			SPEED = 0
			speedOffset = 5
			turnOffset = 1
			global_position.z += 0
			
	global_transform.origin += -global_transform.basis.z * SPEED * delta
	
	if not Global.policeActivated:
		Global.distanceLeft -= SPEED * 0.025
		$%DistanceText.text = "Distance Left: %d" % Global.distanceLeft
	else:
		$%DistanceText.text = "Distance Left: Lose the police \nto reduce distance!"



func _on_area_3d_area_entered(area):
	print(area.name)
#	Handle Crashing Into Car.
	if area.is_in_group("CarNPC"):
		#print("YES A CAR NPC!!")
		area.get_parent().queue_free()
		Global.carHealth -= randi_range(10,30)
		if not Global.policeActivated:
			call_police()
	if area.name == "GenerateGround":
		# Cloning the ground		
		var ground = load("res://Scenes/ProceduralGeneration/ground.tscn").instantiate()
#		We need to access ground size to calculate how to do proceduaral generation for road rage.
		#print(ground.get_node("ActualGround").size)
		var offset = ground.get_node("ActualGround").size.z
		ground.global_position.z = area.get_parent().global_position.z + offset
		get_tree().root.get_child(2).add_child(ground)
		#print("Ground should be generated")
	if area.name == "RemoveGround":
		area.delete_ground()
	
func _on_lane_switch_timer_timeout():
	canMerge = true

# As soon as the phone call ends, activate police chase.
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "PhoneCall":
		await get_tree().create_timer(6.0).timeout
		$AnimationPlayer.play("RESET")


func _on_police_chase_timer_timeout():
	Global.policeActivated = false
	$%LevelTimer.paused = false
	$%PoliceChaseText.visible = false
	$PoliceSiren.stop()
#	Emit a signal that will be received by car spawners to reset to pre-police chase state.


func _on_game_over_refresh_level():
	restartLevel.emit()
