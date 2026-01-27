extends AudioStreamPlayer

@onready var dialogueLabel = %DialogueLabel
@onready var choiceRect = %ChoiceRect
@onready var choiceLabel = %ChoiceLabel

func _physics_process(delta):
	if get_playback_position() > 0 and get_playback_position() < 3:
		dialogueLabel.text = "Sally: Alright, I think we have had \nenough to drink."
	if get_playback_position() > 3:
		dialogueLabel.text = "Sally: Let's head back and crash at your place."


func _on_finished():
	dialogueLabel.text = ""
	# Transition to driving scene
	var newScene = load("res://Scenes/car_scene.tscn").instantiate()
	var tree = get_tree()
	var cur_scene = tree.get_current_scene()
	tree.get_root().add_child(newScene)
	tree.get_root().remove_child(cur_scene)
	tree.set_current_scene(newScene)
