extends "res://scripts/minigame.gd"

# This signal is called when the minigame finishes
signal minigame_end(win)

# Carries reference to dog result node.
var DOG_RESULT

func _ready():
	#= MINIGAME SETUP =#
	NAME = "Dog Frisbee"
	INSTRUCTION = "CATCH!"
	DURATION = 4.0
	#You can also use the 'difficulty' variable, controlled by the Session, to tweak those values according to the difficulty
	#The difficulty may range from 1(EASY), 2(MEDIUM), 3(HARD) and 4(INSANE)
	print("This minigame has the difficulty level equal to "+str(difficulty))
	# Get references.
	DOG_RESULT = get_node("dog_result")
	
	start()
	pass

func _process(delta):
	
	pass

# Shows minigame result with cute dog.
func show_results(success):
	DOG_RESULT.show_result(success)
	pass

# Activate all objects.
func start():
	DOG_RESULT.start()
	.start()
	show_results(true)
	pass

# Deactivate all objects
func stop():
	DOG_RESULT.stop()
	.stop()
	pass