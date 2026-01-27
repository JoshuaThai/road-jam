extends Area3D

var entered = false

func _on_body_entered(body: PhysicsBody3D) -> void:
	entered = true


func _on_body_exited(body: PhysicsBody3D) -> void:
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"): # Remember to change to 'E' -- Right now it's set up as Enter or Space
			get_tree().change_scene_to_file("res://scenes/driving_scene.tscn")
 
