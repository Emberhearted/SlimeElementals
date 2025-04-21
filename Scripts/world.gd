extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

func _ready() -> void:
	add_child(global.player)

func _physics_process(delta: float) -> void:
	if global.health <= 0:
		add_child(global.gameOver)
