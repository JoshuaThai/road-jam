extends Area3D

func delete_ground():
	get_parent().find_child("DespawnTimer").start()
