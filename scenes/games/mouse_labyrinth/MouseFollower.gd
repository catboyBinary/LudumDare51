extends Area2D

@onready var raycast: RayCast2D = $RayCast2d

const def_pos: Vector2 = Vector2(331, 278)
var last_pos: Vector2 = def_pos
var just_switched: bool = true
var current_area: Area2D
var has_blue_key: bool = false
var has_red_key: bool = false

signal player_hit

func _process(_delta: float) -> void:
	if just_switched:
		position = last_pos
		get_viewport().warp_mouse(last_pos)
		just_switched = false
	else:
		raycast.target_position = position - get_viewport().get_mouse_position()
		if raycast.is_colliding():
			check_door_or_die(raycast.get_collider())
		position = get_viewport().get_mouse_position()
		
		if Input.is_action_pressed("click"):
			if current_area:
				if current_area.is_in_group("Cork"):
					current_area.uncork()
	
func player_respawn():
	emit_signal("player_hit")
	get_viewport().warp_mouse(def_pos)
	
func check_door_or_die(body: Node2D):
	if body.is_in_group("BlueDoor") and has_blue_key:
		body.queue_free()
	elif body.is_in_group("RedDoor") and has_red_key:
		body.queue_free()
	else:
		player_respawn()

func _on_mouse_game_visibility_changed() -> void:
	if get_parent().visible:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		get_parent().get_node("Camera2d").current = true
	else:
		last_pos = position
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_parent().get_node("Camera2d").current = false
		just_switched = true

func _on_mouse_follower_body_entered(body: Node2D) -> void:
	check_door_or_die(body)

func _on_mouse_follower_area_entered(area: Area2D) -> void:
	if area.is_in_group("Cork"):
		current_area = area
	elif area.is_in_group("BlueKey"):
		area.queue_free()
		has_blue_key = true
	elif area.is_in_group("RedKey"):
		area.queue_free()
		has_red_key = true
	elif area.is_in_group("WinMouse"):
		get_parent().add_to_group("completed")
		set_process(false)


func _on_mouse_follower_area_exited(area: Area2D) -> void:
	if area.is_in_group("Cork"):
		current_area = null
