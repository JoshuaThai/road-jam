extends ColorRect


var gameOver = false

var audioName = ["EndingDialogue1", "EndingDialogue2"]
@export var currentAudio = audioName[0]

func _process(delta):
	if gameOver: return
	if Global.carHealth <= 0:
		#print("Car is dead")
		$FailReason.text = "Your car died!"
		gameOver = true
		visible = true


# When player presses play again button.
func _on_play_again_pressed():
	Global._restore_defaults()
	get_tree().reload_current_scene()
	#get_tree().change_scene_to_file("res://Scenes/ProceduralGeneration/road_rage.tscn")
	
# When player presses play ending button.
# Play ending
func _on_play_ending_pressed():
	get_tree().paused = true
	$%PhoneCallAudio.queue_free()
	$%PoliceSiren.queue_free()
	$%Ending.visible = true
	$%Ending.get_node("EndingAudio").play()

func _on_ending_audio_finished():
#	After first ending audio plays, show score
	if currentAudio == audioName[0]:
		$%Ending.get_node("DialogueText").text = "Here is your score:\n" + str(Global.score)
		# Play audio according to score
		if Global.score <= 50:
			currentAudio = audioName[1]
			$%Ending.get_node("EndingAudio").audioName = "null"
			$%Ending.get_node("EndingAudio").stream = load("res://Joshua/Road Rage/Audio/BadScore.mp3")
			$%Ending.get_node("EndingAudio").play()
		else:
			currentAudio = audioName[1]
			$%Ending.get_node("EndingAudio").audioName = "null"
			$%Ending.get_node("EndingAudio").stream = load("res://Joshua/Road Rage/Audio/GoodJob.mp3")
			$%Ending.get_node("EndingAudio").play()
	# Then play the final ending audio.
	elif currentAudio == "Finished":
		get_tree().change_scene_to_file("res://Scenes/main_menu/main_menu.tscn")
	else:
		$%Ending.get_node("EndingAudio").audioName = currentAudio
		$%Ending.get_node("EndingAudio").stream = load("res://Joshua/Road Rage/Audio/EndingDialogue2.mp3")
		$%Ending.get_node("EndingAudio").play()
