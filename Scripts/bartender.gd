extends StaticBody3D

@onready var bartenderAnimation = $BartenderAnimations
var time = 0

func _physics_process(delta):
	if time <= 0:
		bartenderAnimation.play("Wave")
		time = 5
	time -= 1
