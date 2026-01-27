extends Camera3D

@export var max_offset := Vector2(0.15, 0.08) # x = left/right, y = up/down
@export var smoothing := 10.0

var base_pos: Vector3
var target_offset := Vector2.ZERO
var current_offset := Vector2.ZERO

func _ready() -> void:
	base_pos = position
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		target_offset.x = clamp(event.relative.x * 0.002, -max_offset.x, max_offset.x)
		target_offset.y = clamp(-event.relative.y * 0.002, -max_offset.y, max_offset.y)

func _process(delta: float) -> void:
	# smoothly return to center
	target_offset = target_offset.lerp(Vector2.ZERO, delta * 3.0)
	current_offset = current_offset.lerp(target_offset, delta * smoothing)

	position = base_pos + Vector3(current_offset.x, current_offset.y, 0)
