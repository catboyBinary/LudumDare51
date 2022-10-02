extends Area2D

@export var uncorked_position: Vector2

func _ready() -> void:
	set_process(false)
	
func _process(_delta: float) -> void:
	if position == uncorked_position:
		monitorable = false
		set_process(false)
	position = position.lerp(uncorked_position, 0.01)

func uncork():
	set_process(true)
