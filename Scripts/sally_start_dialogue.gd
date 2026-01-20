extends AudioStreamPlayer

@onready var dialogueLabel = %DialogueLabel
@onready var bartender = %Bartender
@onready var choiceRect = %ChoiceRect

func _physics_process(delta):
	if get_playback_position() >0 and get_playback_position() < 3:
		bartender.play_animation()
		dialogueLabel.text = "Sally: Oh John! You are here."
		#print(get_playback_position())
	if get_playback_position() >= 3 and get_playback_position() < 7:
		dialogueLabel.text = "Sally: Ugh. How has your day been?"
	if get_playback_position() > 7 and get_playback_position() < 11:
		dialogueLabel.text = "Sally: Oh. I am sorry to hear that it has been bad."
	if get_playback_position() > 11 and get_playback_position() < 14:
		dialogueLabel.text = "Sally: You should totally relax and take a sip."
	if get_playback_position() > 14:
		dialogueLabel.text = "Sally: I will pay for it."
		
		
	


func _on_finished():
	dialogueLabel.text = ""
	choiceRect.visible = true
