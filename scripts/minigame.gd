extends Node2D

# Minigame's name.
var NAME = "Sampĺe"
# Minigame quick instruction (usually one command verb). Ex: Slide!
var INSTRUCTION = "TAP!"
# Minigame duration in seconds.
var DURATION = 5.0
# Behaviour during timeouts.
var TIMEOUT_WIN = false

# Difficulty Level (ranging from 1 to 4). Don't forget it's set up during _ready(). (it won't work in _init())
var difficulty = 0
# Reference to Timeout.
var time_bar = null
# Boolean for testing scenario.
var testing = false

func _ready():
	#Check if it's a test or a session execution.
	if get_tree().get_root().has_node(self.get_name()):
		#It's a test
		testing = true
	else:
		#It's a session execution.
		testing = false
		#Get properties from calling session.
		difficulty = get_parent().get_parent().current_difficulty
		time_bar = get_parent().get_parent().get_node("game_timer").get_node("ProgressBar")
		print("Difficulty level: "+str(difficulty))
		#Configures initial values for timer.
		time_bar.set_max(DURATION)
		time_bar.set_value(DURATION)

	pass

func _process(delta):
	#Call timer update function.
	if not is_testing():
		update_timer(delta)
	pass

# This method is called right after the minigame starts being playable.
func start():
	#Turns on the game loop.
	set_process(true)
	#Show the timer bar.
	if not is_testing():
		time_bar.show()
	pass

# This method is called after the minigame is won or lost.
func stop():
	#Turns off the game loop.
	set_process(false)
	#Hide the timer bar.
	time_bar.hide()
	pass

# Updates the timer bar values.
func update_timer(delta):
	#Updates remaining time for the minigame.
	var time_percentage = time_bar.get_value()-delta
	time_bar.set_value(time_percentage)
	#Check if time ran out.
	if time_percentage <= 0:
		#End minigame by timeout.
		if not testing:
			emit_signal("minigame_end", TIMEOUT_WIN)
	pass

# Rotate minigame in case its played on vertical.
func rotate_minigame():
	set_pos(Vector2(-get_viewport_rect().size.x/2,get_viewport_rect().size.y/2))
	set_rot(PI/2.0)

# Check if minigame is being played as a standalone node for testing.
func is_testing():
	return time_bar == null

