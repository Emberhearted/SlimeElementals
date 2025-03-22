extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

var wasInAir: bool = false

const speed = 150.0
const jumpVelocity = -275.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += global.gravity * delta
		if not wasInAir:
			animation.play("jumpTakeOff")
	# Checks if you have just landed
		wasInAir = true
		
	if is_on_floor():
		if wasInAir:
			on_land()

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#animation.play("jumpTakeOff")
		velocity.y = jumpVelocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

# This carries out whenever you land
func on_land():
	animation.play("jumpLanding")
	wasInAir = false
