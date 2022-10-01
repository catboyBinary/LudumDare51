class_name GameAnnounce
extends ColorRect

var timer: float = 10

@onready var label: Label = $Label
@onready var time_bar: ColorRect = $TimeBar

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		timer = 10.0
	
	time_bar.size.x = size.x * timer / 10.0
	

func announce(text: String) -> void:
	label.text = text

