extends Control

@onready var label: Label = $TimerLabel
@onready var timer: Timer = $Timer
@onready var game_announce: GameAnnounce = $GameAnnounce
@onready var well_done: ColorRect = $WellDone
@export var game_field: Node

@export var current_game: Node
var next_game: Node
const games: Array[Resource] = [
	preload("res://scenes/games/button_game.tscn"),
	preload("res://scenes/games/fps/fps_game.tscn")
]
var themeCount = 0
const themes = [
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
	game_field.call_deferred("add_child", current_game)

func _on_timer_timeout() -> void:
	match iters:
		0:
			game_announce.announce("PRESS THE BUTTON")
		19:
			#current_game.queue_free()
			current_game.process_mode = Node.PROCESS_MODE_DISABLED
			iters = -1
			$Camera2d/CameraShake.start()
			themeCount += 1
			if themeCount == 4: themeCount = 0
			theme = themes[themeCount]
			
	iters += 1
	
	label.set_text("Time left: " + str(10 - 0.5 * iters))
