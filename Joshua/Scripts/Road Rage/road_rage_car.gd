extends VehicleBody3D

const SPEED = 40

@onready var rear_mirror = $Mirrors/RearViewport/MirrorCamera
#@onready var left_mirror = $SideLViewport/MirrorCamera
#@onready var right_mirror = $SideRViewport/MirrorCamera

@onready var anchor = $Mirrors/RearCamAnchor
#@onready var left_anchor = $LeftCamAnchor
#@onready var right_anchor = $RightCamAnchor

func _process(_dt):
	rear_mirror.global_transform = anchor.global_transform
	#left_mirror.global_transform = left_anchor.global_transform
	#right_mirror.global_transform = right_anchor.global_transform

func _physics_process(delta):
	global_position.z += SPEED * delta



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
	
	
	
