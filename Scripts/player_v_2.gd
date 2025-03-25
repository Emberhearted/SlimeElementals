extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

const speed = 300.0
const jumpVelocity = -325.0

# Checks if player was in air
var was_in_air = false

# Stores prev movement direction
var prev_direction = 1

# Carries out when landing left
func on_land_left():
	animation.play("LandLeft")
	await animation.animation_finished
	if animation.animation == "LandLeft":
		animation.play("IdleBlink")
		
func on_land_right():
	animation.play("LandRight")
	await animation.animation_finished
	if animation.animation == "LandRight":
		animation.play("IdleBlink")

func _physics_process(delta: float) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity.y += global.gravity * delta
	
	# Handle jumping left.
	if Input.is_action_pressed("jump") and Input.is_action_pressed("left") and is_on_floor():
		velocity.y = jumpVelocity
		prev_direction = -1
		animation.play("JumpLeft")

	# Handle jumping right.
	if Input.is_action_pressed("jump") and Input.is_action_pressed("right") and is_on_floor():
		velocity.y = jumpVelocity
		prev_direction = 1
		animation.play("JumpRight")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		prev_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
	# Check for landing
	if was_in_air and is_on_floor():
		if prev_direction < 0:
			on_land_left()
		else:
			on_land_right()
	# U
	was_in_air = not is_on_floor()
