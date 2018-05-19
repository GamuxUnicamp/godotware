extends Node2D

# Minigame's name.
export(String) var NAME = "Sample"
# Minigame quick instruction (usually one command verb). Ex: Slide!
export(String) var INSTRUCTION = "TAP!"
# Minigame duration in seconds.
export(int) var DURATION = 5.0
# Behaviour during timeouts.
export(bool) var TIMEOUT_WIN = false
# Does it use keys?
export(bool) var USE_KEYS_HUD = false
# Does it use mouse?
export(bool) var USE_MOUSE_HUD = false

# Difficulty Level (ranging from 1 to 4). Don't forget it's set up during _ready(). (it won't work in _init())
onready var difficulty = 0
# Reference to Timeout.
onready var time_bar = null
# Boolean for testing scenario.
onready var testing = false
# Determinate if duration was set.
onready var time_set = false

func _ready():
	#Check if it's a test or a session execution.
	if get_tree().get_root().has_node(self.get_name()):
		#It's a test execution.
		testing = true
	else:
		#It's a session execution.
		testing = false
		#Get properties from calling session.
		difficulty = global.selected_difficulty
		time_bar = get_parent().get_parent().get_node("game_timer").get_node("ProgressBar")
		print("Difficulty level: "+str(difficulty))
	print("This minigame has the difficulty level equal to "+str(difficulty))
	pass

func _process(delta):
	if not testing:
		#Configures initial values for timer.
		if not time_set:
			time_bar.set_max(DURATION)
			time_bar.set_value(DURATION)
			time_set = true
		#Call timer update function.
		update_timer(delta)
	pass

# This method is called right after the minigame starts being playable.
func start():
	#Turns on the game loop.
	set_process(true)
	#Show the timer bar.
	if not testing:
		time_bar.show()
	pass

# This method is called after the minigame is won or lost.
func stop():
	#Turns off the game loop.
	set_process(false)
	#Hide the timer bar.
	if not testing:
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


