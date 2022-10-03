extends AnimatableBody2D

@export var keyframes : Array[Vector2]
@export var duration : float = 1
@export var interval : float = 0
@export var delay : float = 0
@export var easing : Tween.EaseType
@export var transition : Tween.TransitionType
# Called when the node enters the scene tree for the first time.
func _ready():
	await create_tween().tween_interval(delay).finished
	var tw = create_tween().set_ease(easing).set_trans(transition).set_loops()
	for key in keyframes:
		tw.tween_property(self, "position", key*3, duration).as_relative()
		tw.tween_interval(interval)
