extends Node3D


func _ready():
	get_tree().paused = true
	
func reset():
	print(get_tree().current_scene.name)
	get_tree().change_scene_to_file("res://Scenes/ProceduralGeneration/road_rage.tscn")


func _on_player_restart_level():
	reset()
