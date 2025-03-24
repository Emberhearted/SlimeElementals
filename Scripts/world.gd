extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
