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
	BUBBLES_NUM = number_of_bubbles(difficulty)

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

func start():
	# Call all bubbles to stop handling touch
	get_tree().call_group(0, "bubble", "start")
	# Call father's version function
	.start()
	pass

func stop():
	# Call all bubbles to stop handling touch
	get_tree().call_group(0, "bubble", "stop")
	# Call father's version function
	.stop()
	pass

# Returns the number of bubbles, according to the current difficulty value
func number_of_bubbles(difficulty):
	if difficulty == 1: #EASY
		return 3
	elif difficulty == 2: #MEDIUM
		return 4
	elif difficulty == 3: #HARD
		return 7
	elif difficulty == 4: #INSANE
		return 10
	return 4 #NOT_DEFINED