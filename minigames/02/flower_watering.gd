extends "res://scripts/minigame.gd"

#=== MINIGAME BOILERPLATE ===#

#-> Check inherited file scripts/minigame.gd for more details

# This signal is called when the minigame finishes
signal minigame_end(win)
# Signal triggered when a flower blossoms
signal flower_blossomed

# Holds a reference to flower's scene
var FLOWER_REF = preload("res://minigames/02/flower.tscn")
# Holds valid spots for flower spawning in the x axis
var FLOWER_SPOTS = [90, 170, 250, 330, 410, 490, 570]

# Number of spawned flowers. Controlled by difficulty
var num_flowers
# Number of completed flowers
var flowers_count


func _ready():
	#= MINIGAME SETUP =#
	#Setup for basic informations regarding your minigame. Check scripts/minigame.gd file for other configurable values
	NAME = "Flower Watering"
	INSTRUCTION = "WATER!"
	DURATION = 2.5
	print("This minigame has the difficulty level equal to "+str(difficulty))
	#
	flowers_count = 0
	num_flowers = number_of_flowers(difficulty)
	for i in range(0,num_flowers):
		randomize()
		var pos_index = int(rand_range(0,FLOWER_SPOTS.size()))
		var pos_x = FLOWER_SPOTS[pos_index]
		FLOWER_SPOTS.remove(pos_index)
		var flower = FLOWER_REF.instance()
		flower.set_pos(Vector2(pos_x,315))
		flower.connect("flower_blossomed", self, "new_flower")
		get_node("flower_manager").add_child(flower)

	pass

func _process(delta):
	#This is the main game loop. Implement your main mechanics here
	#To finish the game with a victory, use:
	#		emit_signal("minigame_end", true)
	#To finish the game with a defeat, use:
	#		emit_signal("minigame_end", false)
	#Be wary that timeouts may trigger defeat by default. You can change that by tweaking with TIMEOUT_WIN variable in setup
	pass

# Starts all relevant nodes in scene
func start():
	# Calls start functions in all active nodes
	get_tree().call_group(0, "cloud", "start")
	get_tree().call_group(0, "flowers", "start")
	# Call father's version function
	.start()

# Stops all relevant nodes in scene
func stop():
	# Calls stop functions in all active nodes
	get_tree().call_group(0, "cloud", "stop")
	get_tree().call_group(0, "drops", "stop")
	get_tree().call_group(0, "flowers", "stop")
	# Call script's own stop function
	.stop()
	pass

# Returns the number of flowers, according to the current difficulty value
func number_of_flowers(difficulty):
	if difficulty == 1: #EASY
		return 3
	elif difficulty == 2: #MEDIUM
		return 5
	#HARD and INSANE
	return 7

# Function is called when new flower blossoms
func new_flower():
	#Add to flower counter
	flowers_count += 1
	#If flowers count is greater then difficulty, wins
	if flowers_count >= num_flowers:
		TIMEOUT_WIN = true
	pass
