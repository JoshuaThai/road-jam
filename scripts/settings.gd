extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var volume: Panel = $Volume
@onready var resolution: Panel = $Resolution


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	volume.visible = false
	resolution.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")



func _on_resolution_pressed() -> void:
	main_buttons.visible = false
	resolution.visible = true


func _on_volume_pressed() -> void:
	main_buttons.visible = false
	volume.visible = true


func _on_back_button_pressed() -> void:
	_ready()

	
