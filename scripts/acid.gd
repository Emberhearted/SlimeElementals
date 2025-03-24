extends Area2D

@export var damage: int = 1  # How much damage the acid deals

func _on_body_entered(body):
	if body.is_in_group("Player"):  # Make sure player is in "Player" group
		body.take_damage(damage)  # Call damage function on player
