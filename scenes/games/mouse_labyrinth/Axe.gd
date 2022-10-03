extends Area2D

@export var default_pos: Vector2
@onready var sprite: Node2D = $Axe

func _ready() -> void:
	set_physics_process(false)
	position = default_pos
	
func _physics_process(delta: float) -> void:
	position = get_viewport().get_mouse_position()
	if Input.is_action_pressed("click"):
		monitoring = true
		rotate(delta * 30)
	else:
		call_deferred("disable_axe")
		rotation = lerp_angle(rotation, 0, 0.1)
		
func disable_axe():
	monitoring = false

func _on_axe_body_entered(body: Node2D) -> void:
	body.queue_free()

func _on_axe_area_entered(_area: Area2D) -> void:
	set_physics_process(true)

func _on_mouse_follower_player_hit() -> void:
	set_physics_process(false)
	monitoring = true
	position = default_pos
