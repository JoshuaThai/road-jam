extends CSGBox3D

@onready var car = load("res://Characters/car_NPC.tscn")

func spawn_car():
	var npc = car.instantiate()
	#npc.global_rotation = Vector3(0,rotations[0],0)
	npc.correct_rotation = 90
	npc.global_position = global_position
	get_parent().add_child(npc)

# NPC SPAWNER TO THE RIGHT
func _on_timer_timeout():
	var randNumbDrunk = randi_range(1, 2)
	if Global.drunk and randNumbDrunk%2 == 0:
		spawn_car()
	else:
		var randNumb = randi_range(1, 4)
		if randNumb == 2:
			spawn_car()
