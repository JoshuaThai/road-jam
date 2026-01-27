extends Node3D

@export var speed := 20.0
var driving := true

func _process(delta: float) -> void:
	if not driving:
		return
	global_position += -global_transform.basis.z * speed * delta
