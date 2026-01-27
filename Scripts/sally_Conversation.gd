extends Label3D

@onready var player = %Player
@onready var dialogueLabel = %DialogueLabel
@onready var sallyStartingDialogue = %SallyStartDialogue
@onready var sallyAnimations = %SallyAnimations
@onready var sallyBody = %Sally
@onready var playerStand = %PlayerStand

@export var narratorDone = false
var dialogueStarted = false

func _physics_process(delta):
	var playerPosition = global_position - player.global_position
	if playerPosition.x > -3 and playerPosition.z > -3 and narratorDone:
		if not dialogueStarted:
			visible = true
		if Input.is_key_pressed(Key.KEY_E) and not dialogueStarted:
			visible = false
			player.SPEED = 0.0
			dialogueStarted = true
			player.global_position = playerStand.global_position
			sallyAnimations.play("Turning")
			sallyStartingDialogue.play()
		#print(playerPosition)


func _on_narrator_dialogue_finished():
	narratorDone = true
	dialogueLabel.text = ""
