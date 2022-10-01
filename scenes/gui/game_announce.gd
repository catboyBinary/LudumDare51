class_name GameAnnounce
extends ColorRect

var timer: float = 10

@onready var label: Label = $Label
@onready var time_bar: ColorRect = $TimeBar
var TW: Tween

func _process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		timer = 10.0
	
	time_bar.size.x = size.x * timer / 10.0
	time_bar.color.h = (100 + (10 - timer) * 26) / 360
	

func announce(text: String) -> void:
	label.text = text

