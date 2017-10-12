extends "res://scripts/minigame.gd"

# This signal is called when the minigame finishes
signal minigame_end(win)

var BUBBLE_REF = preload("res://minigames/00/bubble.tscn")
var BUBBLES_NUM = 0

var bubble_handler
var bubble

func _ready():
	#= MINIGAME SETUP =#
	NAME = "Bubble Popper"
	INSTRUCTION = "POP!"
	DURATION = 2.0
	# Set number of bubbles
	BUBBLES_NUM = difficulty

	# Instantiate bubbles
	bubble_handler = get_node("bubble_handler")
	for i in range (BUBBLES_NUM):
		bubble = BUBBLE_REF.instance()
		bubble.translate(Vector2(20*i,0))
		bubble_handler.add_child(bubble)
	pass


func _process(delta):
	var bubble_count = bubble_handler.get_children().size()
	# If there are no more bubbles, player wins
	if(bubble_count == 0):
		emit_signal("minigame_end", true)
	else:
		var bubbles = bubble_handler.get_children()
		for i in range (bubble_count):
			bubbles[i].process(delta)
	pass
