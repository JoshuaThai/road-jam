extends Node3D

@onready var pause: Panel = $Pause
var is_paused := false

func _ready() -> void:
	pause.visible = false
	pause.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not event.is_echo():
		toggle_pause()

func toggle_pause() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
	pause.visible = is_paused
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if is_paused else Input.MOUSE_MODE_CAPTURED)

func resume_game() -> void:
	is_paused = false
	get_tree().paused = false
	pause.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_back_button_pressed() -> void:
	resume_game()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_main_menu_pressed() -> void:
	resume_game()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
	
	
