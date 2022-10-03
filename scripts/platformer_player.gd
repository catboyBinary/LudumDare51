extends CharacterBody2D


const SPEED := 400.0
const JUMP_VELOCITY := 500.0
var spawn_position : Vector2 = Vector2(312,400)
var last_up_direction : Vector2 = up_direction

var base_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity: float = base_gravity * 1.2

func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * up_direction.y
		
	if Input.is_action_just_pressed("move_right") and not Input.is_action_pressed("move_left"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("leanRight")
	elif Input.is_action_just_pressed("move_left") and not Input.is_action_pressed("move_right"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play("leanLeft")
		
	if Input.is_action_just_released("move_left") and not Input.is_action_pressed("move_right"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play_backwards("leanLeft")
		$AnimationPlayer.seek(0.35)
	elif Input.is_action_just_released("move_right") and not Input.is_action_pressed("move_left"):
		$AnimationPlayer.stop()
		$AnimationPlayer.play_backwards("leanRight")
		$AnimationPlayer.seek(0.35)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if (direction != 0):
		$AnimatedSprite2d.flip_h = direction < 0

	move_and_slide()


func _on_platformer_2d_visibility_changed() -> void:
	if get_parent().visible:
		$Camera2d.current = true
	else:
		$Camera2d.current = false


func _on_area_2d_area_entered(area) -> void:
	if area.is_in_group("jump_pad"): 
		velocity.y = -JUMP_VELOCITY * area.scale.y * 1.35
	# Пад не может ведь быть прыжковым и гравитационным одновременно?
	# if area.is_in_group("gravity_pad"):
	# какая в жопу разница???
	elif area.is_in_group("gravity_pad"):
		velocity.y = -JUMP_VELOCITY * area.scale.y
		up_direction = Vector2(0, area.scale.y)
		gravity = -base_gravity * 1.2 * up_direction.y
		$AnimatedSprite2d.flip_v = bool(up_direction.y+1)
	elif area.is_in_group("death"):
		die()
	elif area.is_in_group("checkpoint") and (spawn_position != area.position or last_up_direction != up_direction):
		spawn_position = area.position
		last_up_direction = up_direction
		
		
func die() -> void:
	up_direction = last_up_direction
	gravity = base_gravity * 1.2 * -up_direction.y
	position = spawn_position
	velocity = Vector2.ZERO
	$AnimatedSprite2d.flip_v = bool(up_direction.y+1)
