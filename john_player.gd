extends CharacterBody2D

const SPEED := 400.0
const GRAVITY := 1200.0
const JUMP_VELOCITY := -450.0

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	# Jump
	if Input.is_key_pressed(Key.KEY_SPACE) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement ONLY
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	move_and_slide()
