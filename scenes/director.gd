extends Control

@onready var label: Label = $TimerLabel
@onready var timer: Timer = $Timer
@onready var game_announce: GameAnnounce = $GameAnnounce
@onready var well_done: ColorRect = $WellDone
@onready var camera: Camera2D = $Camera2d

var current_game: int = 0
@export var game_switcher: Node

var themeCount = 0
const themes: Array[Theme] = [
	preload("res://themes/theme.tres"),
	preload("res://themes/theme1.tres"),
	preload("res://themes/theme2.tres"),
	preload("res://themes/theme3.tres")
]

# Вместо того чтобы постоянно отслеживать время,
# Мы отслеживаем только каждые полсекунды
# Для того чтобы все переходы были в ритм 120бпм
var iters: int = 0

func _ready() -> void:
	timer.start()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _on_timer_timeout() -> void:
	match iters:
		0:
			game_announce.announce("PRESS THE BUTTON")
		19:
			#current_game.queue_free()
			iters = -1
			$Camera2d/CameraShake.start()
			themeCount = (themeCount + 1) % len(themes)
			theme = themes[themeCount]
			game_switcher.next_game()
			
	iters += 1
	
	label.set_text(str(10.0 - 0.5 * iters) + "s")
