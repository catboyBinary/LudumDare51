extends RigidBody2D

func _on_ball_body_entered(body: Node) -> void:
	if body.is_in_group("Glass"):
		body.queue_free()
		can_sleep = true
