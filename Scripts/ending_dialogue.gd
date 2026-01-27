extends Label
@export var dialogueList = []

var GoodAudio = "res://DrunkDrivingDialogue/GoodEnding.mp3"
var BadAudio = "res://DrunkDrivingDialogue/BadEnding.mp3"
var drunkAudio = "res://DrunkDrivingDialogue/GoodEndingDrunk.mp3"

var endingType = ""

signal endingReceived

func _ready():
	endingReceived.connect(_play_ending)
	
func _physics_process(delta):
	if endingType == "Good":
		if $DialogueAudio.get_playback_position() > 0 and $DialogueAudio.get_playback_position() <= 2:
			text = "Yay! You made it home safe!"
		if $DialogueAudio.get_playback_position() > 2 and $DialogueAudio.get_playback_position() <= 5:
			text = "I am proud of the decisions you have made so far kid."
		if $DialogueAudio.get_playback_position() > 5:
			text = "Keep it up!"
	elif endingType == "Bad":
		if $DialogueAudio.get_playback_position() > 0 and $DialogueAudio.get_playback_position() <= 2.25:
			text = "I warned you. Didn't I?"
		if $DialogueAudio.get_playback_position() > 2.25 and $DialogueAudio.get_playback_position() <= 4:
			text = "Now look at what happened."
		if $DialogueAudio.get_playback_position() > 4 and $DialogueAudio.get_playback_position() <= 7:
			text = "All actions have consequences, my friend!"
		if $DialogueAudio.get_playback_position() > 7:
			text = "Let's hope you do better in the future situations."
	else:
		if $DialogueAudio.get_playback_position() > 0 and $DialogueAudio.get_playback_position() <= 3.5:
			text = "Well you made it home safe. Unscatched."
		if $DialogueAudio.get_playback_position() > 3.5 and $DialogueAudio.get_playback_position() <= 7.4:
			text = "I am shocked that you actually did it. But you did."
		if $DialogueAudio.get_playback_position() > 7.4 and $DialogueAudio.get_playback_position() <= 14:
			text = "Unfortunately, it doesn't change the fact that the neighbors 
			called the police on you over your fast driving."
		if $DialogueAudio.get_playback_position() > 14 and $DialogueAudio.get_playback_position() < 18.25:
			text = "So you will still have to bear the consequences of your actions."
		if $DialogueAudio.get_playback_position() > 18.25:
			text = "I warned you. Let's hope you do better in future situations."
func _play_ending(endingReceived):
	endingType = endingReceived
	print(endingType)
	if endingType == "Good":
		$DialogueAudio.stream = AudioStreamMP3.load_from_file(GoodAudio)
		$DialogueAudio.play()
	if endingType == "Bad":
		$DialogueAudio.stream = AudioStreamMP3.load_from_file(BadAudio)
		$DialogueAudio.play()
	else:
		$DialogueAudio.stream = AudioStreamMP3.load_from_file(drunkAudio)
		$DialogueAudio.play()


func _on_dialogue_audio_finished():
	get_tree().quit()
