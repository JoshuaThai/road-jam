extends CSGBox3D

@onready var car = load("res://Characters/car_NPC.tscn")
@onready var player = %carPlayer

func spawn_car():
	var npc = car.instantiate()
	#npc.global_rotation = Vector3(0,rotations[0],0)
	npc.speed = randi_range(10,20)
	npc.global_position = global_position
	get_parent().add_child(npc)
# NPC SPAWNER TO THE RIGHT
func _on_timer_timeout():
	var playerDistance = player.global_position - global_position
	if playerDistance.z >= -15:
		print("Too close to spawner")
		return
	#print(playerDistance.z)
	var randNumbDrunk = randi_range(1, 2)
	if Global.drunk and randNumbDrunk%2 == 0:
		#print("Timer ran out")
		spawn_car()
		
	else:
		#var npc = car.instantiate()
		##npc.global_rotation = Vector3(0,rotations[0],0)
		#npc.correct_rotation = 0
		#npc.speed = randi_range(10,20)
		#npc.global_position = global_position
		#get_parent().add_child(npc)
		var randNumb = randi_range(1, 4)
		if randNumb == 2:
			spawn_car()
