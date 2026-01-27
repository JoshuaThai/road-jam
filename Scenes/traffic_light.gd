extends StaticBody3D


func change_to_red():
	$GreenLight.visible = false
	$YellowLight.visible = true
	$GreenTimer.stop()
	$Timer.start()

#func change_to_green():
	#$GreenLight.visible = true
	#$RedLight.visible = false
	#$YellowLight.visible = true


# Finish switching to red.
func _on_timer_timeout():
	$YellowLight.visible = false
	$RedLight.visible = true
	$GreenTimer.start()


func _on_green_timer_timeout():
	$GreenLight.visible = true
	$RedLight.visible = false
	$YellowLight.visible = false


#func _on_area_3d_body_entered(body):
	#if body.name.contains("CarNPC"):
		#body.queue_free()
	#print(body.name + "passed traffic light")


func _on_area_3d_area_entered(area):
	if area.name.contains("CarNPC"):
		area.get_parent().queue_free()
	#print(area.name + "passed traffic light")
