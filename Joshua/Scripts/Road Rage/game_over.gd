extends ColorRect

signal refreshLevel

var gameOver = false

func _process(delta):
	if gameOver: return
	if Global.carHealth <= 0:
		#print("Car is dead")
		gameOver = true
		visible = true


# When player presses play again button.
func _on_play_again_pressed():
	Global._restore_defaults()
	refreshLevel.emit()
	#get_tree().change_scene_to_file("res://Scenes/ProceduralGeneration/road_rage.tscn")
	
# When player presses play ending button.
func _on_play_ending_pressed():
	pass # Replace with function body.
