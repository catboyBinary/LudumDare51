extends StaticBody2D

@export var platform: RigidBody2D

func _exit_tree() -> void:
	platform.freeze = false
