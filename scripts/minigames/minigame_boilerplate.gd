extends "res://scripts/minigame.gd"

#=== MINIGAME BOILERPLATE ===#

# This signal is called when the minigame finishes
signal minigame_end(win)

func _ready():
	#= MINIGAME SETUP =#
    #Setup for basic informations regarding your minigame. Check the minigame.gd file for other configurable values
	NAME = "Sample Microgame"
	INSTRUCTION = "TAP!"
	DURATION = 3.0
    #You can also use the 'difficulty' variable, controlled by the Session, to tweak those values according to the difficulty
    print("This minigame has the difficulty level equal to "+str(difficulty))
	#The command 'set_process(true)' is already called on base class _ready() function. It's not necessary to use it again.
	pass

func _process(delta):
	#This is the main game loop. Implement your main mechanics here
	#To finish the game with a victory, use:
	#		emit_signal("minigame_end", true)
	#To finish the game with a defeat, use:
	#		emit_signal("minigame_end", false)
	#Be wary that timeouts may trigger defeat by default. You can change that by tweaking with TIMEOUT_WIN variable in setup
	pass
