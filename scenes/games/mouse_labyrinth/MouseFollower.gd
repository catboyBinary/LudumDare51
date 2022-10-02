extends Area2D

@onready var raycast: RayCast2D = $RayCast2d

var last_pos: Vector2 = Vector2(300, 300)
var just_switched: bool = false
var current_area: Area2D

signal player_hit

func _process(_delta: float) -> void:
	if just_switched:
		position = last_pos
		get_viewport().warp_mouse(last_pos)
		just_switched = false
	else:
		raycast.target_position = position - get_viewport().get_mouse_position()
		if raycast.is_colliding():
			player_respawn()
		position = get_viewport().get_mouse_position()
		
		if Input.is_action_pressed("click"):
			if current_area:
				if current_area.is_in_group("Cork"):
					current_area.uncork()
	
func player_respawn():
	emit_signal("player_hit")
	get_viewport().warp_mouse(Vector2(300, 300))

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
	player_respawn()

func _on_mouse_follower_area_entered(area: Area2D) -> void:
	if area.is_in_group("Cork"):
		current_area = area


func _on_mouse_follower_area_exited(area: Area2D) -> void:
	if area.is_in_group("Cork"):
		current_area = null
