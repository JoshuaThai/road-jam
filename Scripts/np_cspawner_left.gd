extends CSGBox3D

var rotations = [90, 180, 90]

# NPC SPAWNER TO THE RIGHT
func _on_timer_timeout():
	var randNumbDrunk = randi_range(1, 2)
	if Global.drunk and randNumbDrunk%2 == 0:
		#print("Timer ran out")
		var npc = load("res://Characters/NPC.tscn").instantiate()
		#npc.global_rotation = Vector3(0,rotations[0],0)
		npc.global_position = global_position + Vector3(0,3,0)
		get_parent().add_child(npc)
	else:
		var randNumb = randi_range(1, 4)
		if randNumb == 2:
			var npc = load("res://Characters/NPC.tscn").instantiate()
			#npc.global_rotation = Vector3(0,rotations[0],0)
			npc.global_position = global_position + Vector3(0,3,0)
			get_parent().add_child(npc)
