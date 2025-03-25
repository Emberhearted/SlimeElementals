extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

const speed = 300.0
const jumpVelocity = -325.0

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
	# Add the gravity.
	if not is_on_floor():
		velocity.y += global.gravity * delta
	
	# Handle jump left.
	if Input.is_action_pressed("jump") and Input.is_action_pressed("left") and is_on_floor():
		velocity.y = jumpVelocity
		if velocity.x <= 0:
			animation.play("JumpLeft")
			if is_on_floor():
				on_land_left()

	# Handle jump right.
	if Input.is_action_pressed("jump") and Input.is_action_pressed("right") and is_on_floor():
		velocity.y = jumpVelocity
		if velocity.x <= 0:
			animation.play("JumpRight")
			if is_on_floor:
				on_land_right()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
