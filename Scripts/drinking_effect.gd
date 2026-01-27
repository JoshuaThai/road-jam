extends AudioStreamPlayer

@onready var finalDialogue = get_parent().get_parent().get_node("FinalDialogue")

func _physics_process(delta):
	if get_playback_position() > 4:
		stop()
		#print("finalDialogue", finalDialogue)
		finalDialogue.play()
		get_parent().queue_free()
