extends "res://scripts/minigame.gd"

# This signal is called when the minigame finishes
signal minigame_end(win)

func _ready():
	#= MINIGAME SETUP =#
	NAME = "Bubble Popper"
	INSTRUCTION = "POP!"
	DURATION = 3.0
	#> set_process(true) is already called on base class' _ready()
	pass

func _process(delta):
	if(get_node("bubble_handler").get_children().size()==0):
		emit_signal("minigame_end", true)
	pass
