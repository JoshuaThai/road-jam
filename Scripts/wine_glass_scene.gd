extends Node3D

func play_drink_animation():
	$DrinkingEffect.play()
	$AnimationPlayer.play("Drinking")
