extends RigidBody3D

#@onready var NPCAnimations = %NPCAnimations
var time = 0
var non_drunk_rotations = [0,90,180]
var drunk_rotations = [90,180]

func _ready():
	set_global_rotation(Vector3(0,deg_to_rad(drunk_rotations[randi_range(0,len(drunk_rotations) - 1)]),0))
	#while()
	#global_position = global_position
	#pass
	#NPCAnimations.play("WalkStraight")

#func _physics_process(delta):
	#if time <= 0:
		#bartenderAnimation.play("Wave")
		#time = 5
	#time -= 1


func _on_movement_timer_timeout():
	var forward = -global_transform.basis.z
	linear_velocity = forward.normalized() * 5


func _on_delete_timer_timeout():
	queue_free()
