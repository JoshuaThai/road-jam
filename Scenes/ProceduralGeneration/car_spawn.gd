extends CSGBox3D

#@onready var carNPCs = ["res://Joshua/Vehicles/CarNPCS/blue_car.tscn", 
#"res://Joshua/Vehicles/CarNPCS/red_car.tscn"]
@onready var carNPCs = [
"res://Joshua/Vehicles/CarNPCS/red_car.tscn"]

# This will spawn a car NPC
func _on_spawn_timer_timeout():
	var spawnCar = load(carNPCs[0]).instantiate()
	get_tree().get_root().add_child(spawnCar)
	spawnCar.global_position = global_position
	#pass # Replace with function body.
