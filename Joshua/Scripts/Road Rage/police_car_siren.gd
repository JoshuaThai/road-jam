extends Node3D

@onready var blueLight = $BlueLight/OmniLight3D
@onready var redLight = $RedLight/OmniLight3D



func _on_siren_timer_timeout():
	if blueLight.visible:
		blueLight.visible = not blueLight.visible
		redLight.visible = not redLight.visible
	else:
		redLight.visible = not redLight.visible
		blueLight.visible = not blueLight.visible
		
