extends Area2D

@export var damage: int = 1  # How much damage the acid deals

const speed = 60

var direction = 1

@onready var ray_cast_down_left: RayCast2D = $RayCast_DownLeft
@onready var ray_cast_down_right: RayCast2D = $RayCast_DownRight
@onready var ray_cast_side_left: RayCast2D = $RayCast_SideLeft
@onready var ray_cast_side_right: RayCast2D = $RayCast_SideRight

func _process(delta):
	if not ray_cast_down_left.is_colliding():
		direction = 1
	if not ray_cast_down_right.is_colliding():
		direction = -1
	if ray_cast_side_left.is_colliding():
		direction = 1
	if ray_cast_side_right.is_colliding():
		direction = -1
	position.x += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("Player"):  # Make sure player is in "Player" group
		body.take_damage(damage)  # Call damage function on player
