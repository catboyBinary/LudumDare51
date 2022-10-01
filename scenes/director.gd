extends Control

@onready var label: Label = $TimerLabel
@onready var timer: Timer = $Timer
@onready var game_announce: GameAnnounce = $GameAnnounce
@onready var well_done: ColorRect = $WellDone
@export var game_field: Node

var current_game: Node
var next_game: Node
const games: Array[Resource] = [
	preload("res://scenes/games/button_game.tscn")
]

# Вместо того чтобы постоянно отслеживать время,
# Мы отслеживаем только каждые полсекунды
# Для того чтобы все переходы были в ритм 120бпм
var iters: int = 0

func _ready() -> void:
	timer.start()
	current_game = games[0].instantiate()
	game_field.call_deferred("add_child", current_game)

func _on_timer_timeout() -> void:
	match iters:
		0:
			game_announce.announce("PRESS THE BUTTON")
		19:
			#current_game.queue_free()
			iters = -1
			
	iters += 1
	
	label.set_text("Time left: " + str(10 - 0.5 * iters))
