extends Node2D

# This signal is called when the minigame finishes
signal minigame_end(win)

# This is the instance of the running minigame
var running_minigame

func _ready():
	pass

func _start_minigame(minigame_ref):
	# Starts minigame
	running_minigame = scene.instance()
	add_child(running_minigame)
	# Listen to its end
	running_minigame.connect("minigame_end",self,"close_minigame")
	
func _close_minigame(win):
	# Check for win status
	if win:
		print("ganhou")
	else:
		print("perdeu")
	# Remove minigame from stage
	remove_child(minigame)