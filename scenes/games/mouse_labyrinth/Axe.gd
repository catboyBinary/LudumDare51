extends Area2D

@export var default_pos: Vector2

func _ready() -> void:
	set_physics_process(false)
	position = default_pos
	
func _physics_process(delta: float) -> void:
	position = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("click"):
		monitoring = true
	else:
		call_deferred("disable_axe")
		
func disable_axe():
	monitoring = false

func _on_axe_body_entered(body: Node2D) -> void:
	body.queue_free()

func _on_axe_area_entered(area: Area2D) -> void:
	set_physics_process(true)

func _on_mouse_follower_player_hit() -> void:
	set_physics_process(false)
	monitoring = true
	position = default_pos
