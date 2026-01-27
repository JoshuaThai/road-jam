extends AudioStreamPlayer

@onready var dialogueLabel = %DialogueLabel

func _physics_process(delta):
	if get_playback_position() >=5 and get_playback_position() < 10:
		dialogueLabel.text = "Narrator: Always put forth your best judgement\n and be willing to say no."
		#print(get_playback_position())
	if get_playback_position() > 10:
		dialogueLabel.text = "Narrator: Let's test out this advice with \nour pink friend, Sally."
