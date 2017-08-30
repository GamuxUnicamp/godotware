extends Node2D

# This signal is called when the minigame finishes
signal minigame_end(win)

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	if(get_node("bubble_handler").get_children().size()==0):
		emit_signal("minigame_end", true)
	pass
