extends CharacterBody3D

# We will set this set speed to 0 when player is talking to user.
@export var SPEED = 10.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.5
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.2
#		Prevent players from fipping the view.
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80.0, 80.0
		)
#		Show cursor when player clicks escape key.
	elif event.is_action_pressed("ui_cancel"): 
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#	Hide cursor when player clicks enter key
	elif event.is_action_pressed("ui_accept"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _physics_process(delta):
	var input_direction_2D = Input.get_vector(
		"move_left","move_right", "move_up", "move_down"
	)
	
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	
	var direction = transform.basis * input_direction_3D
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	velocity.y -= 20 * delta
	move_and_slide()
	#print(Input.is_action_pressed("move_left"))
	#if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		#var horizontalDir = Input.get_axis("move_left", "move_right")
		#print("HorizontalDirection: ", horizontalDir)
		#if horizontalDir < 0.0:
			#velocity.x -= horizontalDir * SPEED * delta
		#else:
			#velocity.x += horizontalDir * SPEED * delta
		#move_and_slide()
