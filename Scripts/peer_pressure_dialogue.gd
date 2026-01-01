extends AudioStreamPlayer

@onready var dialogueLabel = %DialogueLabel
@onready var choiceRect = %ChoiceRect
@onready var choiceLabel = %ChoiceLabel

func _physics_process(delta):
	if get_playback_position() > 0 and get_playback_position() < 2:
		dialogueLabel.text = "Sally: Oh come on dude!"
		#print(get_playback_position())
	if get_playback_position() >= 2 and get_playback_position() < 4:
		dialogueLabel.text = "Sally: Don't be such a lame."
	if get_playback_position() > 4 and get_playback_position() < 6:
		dialogueLabel.text = "Sally: Just try a little."
	if get_playback_position() > 6 and get_playback_position() < 9:
		dialogueLabel.text = "Sally: Pfft it is not like you will get\ndrunk from one glass."
	if get_playback_position() > 9:
		dialogueLabel.text = "Sally: I promise you the drinks taste great here."


func _on_finished():
	dialogueLabel.text = ""
	choiceRect.visible = true
	choiceLabel.text = "Drinking before driving is DANGEROUS!
	Saying NO is always okay!\nWill you accept the drink?"
