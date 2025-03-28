extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

const speed = 150.0
const jumpVelocity = -300.0

var yVelocity = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += global.gravity * delta
		
	if is_on_floor() and yVelocity > 50:
		yVelocity = velocity.y
		on_land()
	else:
		yVelocity = velocity.y

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		animation.play("jumpTakeOff")
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
	await animation.animation_finished
	if animation.animation == "jumpLanding":
		animation.play("idle")
