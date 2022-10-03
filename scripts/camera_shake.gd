extends Node

const TRANS = Tween.TRANS_LINEAR
const EASE = Tween.EASE_IN_OUT

var amplitude = 0
var priority = 0
@onready var camera = get_parent()

func start(duration = 0.075, frequency = 45, amplitude = 8, priority = 0):
	if (priority >= self.priority):
		self.priority = priority
		self.amplitude = amplitude

		$Duration.wait_time = duration
		$Frequency.wait_time = 1 / float(frequency)
		$Duration.start()
		$Frequency.start()

		_new_shake()

func _new_shake():
	var rand = Vector2()
	rand.x = randi_range(-amplitude, amplitude)
	rand.y = randi_range(-amplitude, amplitude)

	var tween : Tween = create_tween()
	tween.set_ease(EASE)
	tween.set_trans(TRANS)
	tween.tween_property(camera, "offset", rand, $Frequency.wait_time)
	tween.play()

func _reset():
	var tween : Tween = create_tween()
	tween.set_ease(EASE)
	tween.set_trans(TRANS)
	tween.tween_property(camera, "offset", Vector2(), $Frequency.wait_time)
	tween.play()

	priority = 0


func _on_frequency_timeout():
	_new_shake()


func _on_duration_timeout():
	_reset()
	$Frequency.stop()
