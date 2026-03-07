extends StaticBody3D

func _on_despawn_timer_timeout():
	queue_free()

# Destroy cars if they try to across to wrong side.
func _on_destroy_car_area_entered(area):
	if area.is_in_group("CarNPC"):
		area.get_parent().queue_free()
