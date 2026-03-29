extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# =========================
# |   Main Menu Buttons   |
# =========================

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/ProceduralGeneration/road_rage.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/Settings.tscn")


func _on_Characters_pressed() -> void:
	print("Characters Button Pressed")


func _on_about_pressed() -> void:
	OS.shell_open("https://www.linkedin.com/company/dead-signal-studio/")
	#print("About Button Pressed")

func _on_exit_pressed() -> void:
	get_tree().quit()
