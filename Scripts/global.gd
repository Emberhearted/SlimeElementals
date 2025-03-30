extends Node

var gravity = 900

var health = 8

@onready var player = load("res://Scenes/player_v_2.tscn").instantiate()
@onready var gameOver = load("res://Scenes/game_over_ui.tscn").instantiate()
