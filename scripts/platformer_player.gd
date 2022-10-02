extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = 500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")*1.2

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY*up_direction.y
		
	if Input.is_action_just_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("leanRight")
	elif Input.is_action_just_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("leanLeft")
		
	if Input.is_action_just_released("ui_left") and not Input.is_action_pressed("ui_right"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play_backwards("leanLeft")
		$AnimationPlayer.seek(0.35)
	elif Input.is_action_just_released("ui_right") and not Input.is_action_pressed("ui_left"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play_backwards("leanRight")
		$AnimationPlayer.seek(0.35)

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


func _on_platformer_2d_visibility_changed() -> void:
	if get_parent().visible:
		$Camera2d.current = true
	else:
		$Camera2d.current = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("jump_pad"): velocity.y = JUMP_VELOCITY*area.get_parent().scale.y*-1.35
	if area.is_in_group("gravity_pad"): 
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")*-1.2*area.get_parent().scale.y
		up_direction = Vector2(0,area.get_parent().scale.y)
		$AnimatedSprite2d.flip_v = bool(up_direction.y+1)
		
