extends CSGBox3D

#@onready var carNPCs = ["res://Joshua/Vehicles/CarNPCS/blue_car.tscn", 
#"res://Joshua/Vehicles/CarNPCS/red_car.tscn"]
@onready var carNPCs = [
"res://Joshua/Vehicles/CarNPCS/red_car.tscn",
"res://Joshua/Vehicles/CarNPCS/police_car.tscn"
]

@onready var carNPCsFlipped = [
"res://Joshua/Vehicles/CarNPCS/red_car_flipped.tscn",
"res://Joshua/Vehicles/CarNPCS/police_car_flipped.tscn"
]

var somethingNear = false

# This will spawn a car NPC
func _on_spawn_timer_timeout():
#	Do not spawn Car NPC if another car NPC is nearby.
	if somethingNear: return
	var decideToSpawnCar = randi_range(1,4)
	print("Same Side: ", self.get_meta("Flipped"))
	print("SpawnCar: ", decideToSpawnCar)
	#var decideToSpawnCar = 1
	var randIndex = randi_range(0,1)
#	When a police chase is going on, spawn only police cars
	if(Global.policeActivated):
		randIndex = 1
		#	It should be 10 and 15
		$SpawnTimer.wait_time = randf_range(2, 4)
		$SpawnTimer.start()
		if decideToSpawnCar % 2 == 0: return
	else:
		#	It should be 10 and 15
		$SpawnTimer.wait_time = randf_range(5, 8)
		$SpawnTimer.start()
		if decideToSpawnCar % 2 == 0: return
		
	var spawnCar
	if self.get_meta("Flipped"):
#		SHould be 0 and 1
		spawnCar = load(carNPCsFlipped[randIndex]).instantiate()
	#print("Meta: ", self.get_meta("Flipped"))
		spawnCar.direction = -1
		spawnCar.rightPos = -1.0
		spawnCar.leftPos = 4.0
	else:
		spawnCar = load(carNPCs[randIndex]).instantiate()
#	Ensure the car moves accordingly to its starting lane.
	#print("In Left in left lane: ", self.get_meta("inLeft"))
	spawnCar.inLeft = self.get_meta("inLeft")
	get_tree().get_root().add_child(spawnCar)
	if spawnCar.is_in_group("PoliceCar"):
		spawnCar.global_position = global_position + Vector3(0,2,0)
		#spawnCar.global_rotation.y = spawnCar.global_rotation.y * -1
	else:
		spawnCar.global_position = global_position
	#pass # Replace with function body.


func _on_check_touching_area_entered(area):
	print("Car is near: ", area.is_in_group("CarNPC"))
	#print("Same Side: ", self.get_meta("Flipped"))
	#print("Car NPC is nearby. DO NOT SPAWN!")
	if area.is_in_group("CarNPC"):
		somethingNear = true


func _on_check_touching_area_exited(area):
	if area.is_in_group("CarNPC"):
		somethingNear = false


#func _on_destroy_spawn_area_entered(area):
	#if area.get_parent().name == "PlayerCar":
		#get_parent().queue_free()
