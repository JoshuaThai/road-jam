extends Label3D

@onready var player = %Player

@export var narratorDone = false

func _physics_process(delta):
	var playerPosition = global_position - player.global_position
	if playerPosition.x > -3 and playerPosition.z > -3 and narratorDone:
		visible = true
		if Input.is_key_pressed(Key.KEY_E):
			visible = false
		#print(playerPosition)


func _on_narrator_dialogue_finished():
	narratorDone = true
