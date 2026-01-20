extends ColorRect

@onready var choiceLabel = %ChoiceLabel
@onready var peerPressDialog = %PeerPressureDialogue
@onready var finalDial = %FinalDialogue
@onready var player = %Player


func giveGlass():
#	Inititate drinking animation
	var glass = load("res://BarObjects/wine_glass_scene.tscn").instantiate()
	Global.drunk = true
	player.add_child(glass)
	glass.global_position = player.global_transform.origin + player.global_transform.basis * Vector3(0, 1.5, -1)
	glass.play_drink_animation()

# handle player choice screen.
func _physics_process(delta):
	if visible and choiceLabel.text.contains("Saying NO is always okay!"):
		if Input.is_key_pressed(Key.KEY_1):
			Global.bar_points += 5
			visible = false
#			Inititate drinking animation
			giveGlass()

		if Input.is_key_pressed(Key.KEY_2):
			Global.bar_points -= 5
			visible = false
#			Skip to final dialogue
			finalDial.play()
		
		return
	if visible and choiceLabel.text.contains("Will you accept the drink?"):
		if Input.is_key_pressed(Key.KEY_1):
			Global.bar_points += 5
			visible = false
			giveGlass()
		if Input.is_key_pressed(Key.KEY_2):
			Global.bar_points -= 5
			visible = false
			peerPressDialog.play()


func _on_yes_button_pressed():
#	Use choiceLabel's text to determine what to do when button pressing is detected.
	if visible and choiceLabel.text.contains("Saying NO is always okay!"):
		if Input.is_key_pressed(Key.KEY_1):
			Global.bar_points += 5
			visible = false
			giveGlass()
			return
	
#	If yes, then drinking commences.
	if visible and choiceLabel.text.contains("Will you accept the drink?"):
		if Input.is_key_pressed(Key.KEY_1):
			Global.bar_points += 5
			visible = false
			giveGlass()

		


func _on_no_button_pressed():
#	if you say no, final dialogue plays.
	if visible and choiceLabel.text.contains("Saying NO is always okay!"):
		if Input.is_key_pressed(Key.KEY_2):
			Global.bar_points -= 5
			visible = false
			finalDial.play()
			return
	
#	If you say no, peer pressure dialog commence.
	if visible and choiceLabel.text.contains("Will you accept the drink?"):
		if Input.is_key_pressed(Key.KEY_2):
			Global.bar_points -= 5
			visible = false
			peerPressDialog.play()
