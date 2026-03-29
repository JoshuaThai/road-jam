extends AudioStreamPlayer

@export var audioName = "EndingDialogue1"

func _physics_process(delta):
	if audioName == "EndingDialogue1":
		if get_playback_position() < 7:
			$%Ending.get_node("DialogueText").text = "According to the Center for Disease Control,\n
			Motor vehicle crashes are a leading cause of death in the US."
		if get_playback_position() >= 7 and get_playback_position() < 15:
			$%Ending.get_node("DialogueText").text = "Motor Vehicle Crashes are caused by a variety of reasons\n 
			such as distracted driving and drunk driving to name a few."
		if get_playback_position() >= 15 and get_playback_position() < 25:
			$%Ending.get_node("DialogueText").text = "Most of these accidents are preventable as long as\n 
			we choose to slow down, avoid distractions while driving and \navoid driving while impaired."
		if get_playback_position() >= 25:
			$%Ending.get_node("DialogueText").text = "Driving isn't a game. Be safe on the road \nor regret it."
	if audioName == "EndingDialogue2":
		if get_playback_position() < 6:
			$%Ending.get_node("DialogueText").text = "Thank you for playing and we ask that\n 
			you follow Dead Signal Studios on our social media links\n in the main menu."
		if get_playback_position() >= 6:
			$%Ending.get_node("DialogueText").text = "Stay safe on the road and make sure to\n
			 tell a friend about the importance of road safety!"
			$%GameOver.currentAudio = "Finished"
	
