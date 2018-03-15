extends "res://scripts/minigame.gd"

# This signal is called when the minigame finishes.
signal minigame_end(win)
# Signal triggered when frisbee is catch or is missed.
signal frisbee_catch(success)

# Time before throwing the frisbee.
# Frisbee throw duration
# Time after minigame end

# Carries reference to scene elements.
onready var dog_result = get_node("dog_result")
onready var dog_player = get_node("dog")
onready var frisbee = get_node("frisbee")

func _ready():
	#= MINIGAME SETUP =#
	NAME = "Dog Frisbee"
	INSTRUCTION = "CATCH!"
	DURATION = set_duration(difficulty)
	print(DURATION)
	#Connect signal to end game.
	dog_player.connect("frisbee_catch", self, "end_of_game")
	frisbee.connect("frisbee_catch", self, "end_of_game")
	pass

# Initiates frisbee throw.
func throw():
	randomize()
	frisbee.throw(rand_range(50,400),throw_duration(difficulty))
	pass

# Returns the throw duration, according to the current difficulty value.
func throw_duration(difficulty):
	if difficulty == 1: #EASY
		return 2.5
	elif difficulty == 2: #MEDIUM
		return 1.8
	elif difficulty == 3: #HARD
		return 1
	elif difficulty == 4: #INSANE
		return .75
	return 1.8 #NOT_DEFINED

# Returns the minigame duration, according to the current difficulty value
func set_duration(difficulty):
	if difficulty == 1: #EASY
		return 4
	elif difficulty == 2: #MEDIUM
		return 3
	elif difficulty == 3: #HARD
		return 2
	elif difficulty == 4: #INSANE
		return 1.5
	return 3 #NOT_DEFINED

# Shows minigame result.
func end_of_game(success):
	dog_result.show_result(success)
	TIMEOUT_WIN = success
	dog_player.stop()
	frisbee.stop()
	pass

# Activate all objects.
func start():
	get_tree().call_group(0, "activable", "start")
	.start()
	#end_of_game(true)
	throw()
	pass

# Deactivate all objects
func stop():
	get_tree().call_group(0, "activable", "stop")
	.stop()
	pass