extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")*1.2

func _physics_process(delta):
	var tw = create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_CUBIC)
	tw.tween_property($AnimatedSprite2d, "skew", 0, 0.1).as_relative()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("ui_right"):
		tw.parallel().tween_property($AnimatedSprite2d, "rotation", 0.25, 0.5)
	elif Input.is_action_just_pressed("ui_left"):
		tw.parallel().tween_property($AnimatedSprite2d, "rotation", -0.25, 0.5)
	elif Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		tw.parallel().tween_property($AnimatedSprite2d, "rotation", 0, 0.25)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction < 0: $AnimatedSprite2d.flip_h = true
	elif direction > 0: $AnimatedSprite2d.flip_h = false

	move_and_slide()
