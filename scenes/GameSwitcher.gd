class_name GameSwitcher
extends Node

var loops = 0
var children: Array[Node]
var count: int
var current: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	children = get_children()
	count = get_child_count()
	children[current].process_mode = Node.PROCESS_MODE_INHERIT
	children[current].show()

func next_game() -> void:
	children[current].process_mode = Node.PROCESS_MODE_DISABLED
	children[current].hide()
	if children[current].name == "Platformer2D": children[current].find_child("ParallaxBackground").hide()
	if children[(current + 1) % count].is_in_group("completed"): 
		children.erase(children[(current + 1) % count])
		count -= 1
		next_game()
		return
	current = (current + 1) % count
	children[current].process_mode = Node.PROCESS_MODE_INHERIT
	if children[current].name == "Platformer2D": children[current].find_child("ParallaxBackground").show()
	children[current].show()
	if loops < 5: loops += 1
	else: loops = 0
	get_parent().get_parent().get_parent().find_child("Music").seek(loops*10)
	
