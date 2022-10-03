extends Control

var themeCount = 0
const themes = [
	preload("res://themes/theme.tres"),
	preload("res://themes/theme1.tres"),
	preload("res://themes/theme2.tres"),
	preload("res://themes/theme3.tres")
]
const game = preload("res://scenes/Main.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(0.5))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(0.5))
	$Music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	themeCount += 1
	if themeCount == 4: themeCount = 0
	theme = themes[themeCount]
	$Camera2d/CameraShake.start()
	$AudioStreamPlayer.play()


func _on_play_pressed():
	get_tree().change_scene_to_packed(game)


func _on_exit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	var tw = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property($Camera2d, "position", Vector2(0,480), 1)


func _on_credits_2_pressed():
	var tw = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property($Camera2d, "position", Vector2(0,0), 1)


func _on_options_pressed():
	var tw = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property($Camera2d, "position", Vector2(640,0), 1)


func _on_options_2_pressed():
	var tw = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property($Camera2d, "position", Vector2(0,0), 1)


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value/100+0.01))


func _on_h_slider_2_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value/100+0.01))
