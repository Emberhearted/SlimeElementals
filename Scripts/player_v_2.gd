extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

const speed = 300.0
const jumpVelocity = -325.0

var was_in_air = false  # Tracks if player was in the air last frame
var prev_direction = 1   # Stores previous movement direction

# Handles landing left
func on_land_left():
	animation.play("LandLeft")
	await animation.animation_finished
	if animation.animation == "LandLeft":
		animation.play("IdleBlink")
		
# Handles landing right
func on_land_right():
	animation.play("LandRight")
	await animation.animation_finished
	if animation.animation == "LandRight":
		animation.play("IdleBlink")

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity.y += global.gravity * delta
	
	# Handle jump left
	if Input.is_action_just_pressed("jump") and velocity.x <= 0:
		animation.play("JumpLeftBuildUp")
	if Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = jumpVelocity
		prev_direction = -1
		animation.play("JumpLeft")

	# Handle jump right
	if Input.is_action_just_pressed("jump") and velocity.x > 0:
		animation.play("JumpRightBuildUp")
	if Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = jumpVelocity
		prev_direction = 1
		animation.play("JumpRight")
	
	# Get movement input
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		prev_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	# Mid-air turning without restarting the animation
	if not is_on_floor():
		var current_frame = animation.frame  # Store current animation frame

		if velocity.x > 0 and animation.animation != "JumpRight":
			animation.play("JumpRight")
			animation.frame = current_frame  # Continue from the same frame

		elif velocity.x < 0 and animation.animation != "JumpLeft":
			animation.play("JumpLeft")
			animation.frame = current_frame  # Continue from the same frame

	# Move character
	move_and_slide()
	
	# Check for landing
	if was_in_air and is_on_floor():
		if prev_direction < 0:
			on_land_left()
		else:
			on_land_right()
	
	
	was_in_air = not is_on_floor()
