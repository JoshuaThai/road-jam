extends VehicleBody3D

@export var correct_rotation = 180

@export var speed = 20

func _ready():
	set_global_rotation(Vector3(0,deg_to_rad(correct_rotation),0))
	

func _physics_process(delta):
	var forward = global_transform.basis.z
	linear_velocity = forward.normalized() * speed


func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.name.contains("VehicleBody"):
		queue_free()


func _on_area_3d_body_entered(body):
	if body.name.contains("VehicleBody") and not (body == self):
		queue_free()
