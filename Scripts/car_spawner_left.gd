extends CSGBox3D

@onready var car = load("res://Characters/car_NPC.tscn")

var trafficDebounce = false

func spawn_left_car():
	#print("Timer ran out")
	var npc = car.instantiate()
	#npc.global_rotation = Vector3(0,rotations[0],0)
	npc.correct_rotation = -90
	npc.global_position = global_position
	get_parent().add_child(npc)
	
func spawn_right_car():
	#print("Timer ran out")
	var npc = car.instantiate()
	#npc.global_rotation = Vector3(0,rotations[0],0)
	npc.correct_rotation = 90
	npc.global_position = %CarSpawnerRight.global_position
	get_parent().add_child(npc)
	
func change_traffic_light():
	%TrafficLight6.change_to_red()
	%TrafficLight7.change_to_red()
	%TrafficLight8.change_to_red()
	%TrafficLight9.change_to_red()

# NPC SPAWNER TO THE RIGHT
func _on_timer_timeout():
	var randNumbDrunk = randi_range(1, 2)
	if Global.drunk and randNumbDrunk%2 == 0 and not trafficDebounce:
		trafficDebounce = true
		change_traffic_light()
		spawn_left_car()
		spawn_right_car()
		%CooldownTrafTimer.start()
	else:
		var randNumb = randi_range(1, 4)
		if randNumb == 2 and not trafficDebounce:
			trafficDebounce = true
			change_traffic_light()
			spawn_left_car()
			spawn_right_car()
			%CooldownTrafTimer.start()


func _on_cooldown_timer_timeout():
	trafficDebounce = false
