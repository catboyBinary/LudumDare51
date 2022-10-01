extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude = 0
var priority = 0
var tween : Tween
@onready var camera = get_parent()

func _ready():
	tween = create_tween()

func start(duration = 0.2, frequency = 15, amplitude = 16, priority = 0):
	tween.set_ease(EASE)
	tween.set_trans(TRANS)
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

	tween.tween_property(camera, "offset", rand, $Frequency.wait_time)
	tween.play()

func _reset():
	tween.tween_property(camera, "offset", Vector2(), $Frequency.wait_time)
	tween.play()

	priority = 0
