extends Area2D

func _process(delta: float) -> void:
	position = get_global_mouse_position()


func _on_mouse_game_visibility_changed() -> void:
	if get_parent().visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
