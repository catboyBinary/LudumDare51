class_name GameAnnounce
extends ColorRect

var timer: float = 10
var total_timer: float = 0

@onready var label: Label = $Label
@onready var completed: Label = $Completed
@onready var timer_label: Label = $Timer
@onready var time_bar: ColorRect = $TimeBar

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		timer = 10.0
		
	total_timer += delta
	
	time_bar.size.x = size.x * timer / 10.0
	time_bar.color.h = (100 + (10 - timer) * 26) / 360
	completed.text = "Completed " + str(get_tree().get_nodes_in_group("completed").size()) + "/3"
	
	var m := str(int(total_timer) / 60)
	var ms := str(fmod(total_timer, 60)).pad_decimals(2)
	timer_label.text = "Playing time: " + m + ":" + ms
	

func announce(text: String) -> void:
	label.text = text

