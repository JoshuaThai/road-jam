extends CSGBox3D

var rotations = [90, 180, 90]

func _on_timer_timeout():
	print("Timer ran out")
	var npc = load("res://Characters/NPC.tscn").instantiate()
	#npc.global_rotation = Vector3(0,rotations[0],0)
	npc.global_position = global_position + Vector3(0,3,0)
	get_parent().add_child(npc)
