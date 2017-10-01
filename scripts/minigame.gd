extends Node2D

#Minigame's name
var NAME = "Sampĺe"
#Minigame quick instruction (usually one command verb). Ex: Slide!
var INSTRUCTION = "TAP!"
#Minigame duration in seconds
var DURATION = 5.0
#Behaviour during timeouts
var TIMEOUT_WIN = false

#Difficulty Level (ranging from 1 to 10). Don't forget it's set up during _ready() (it won't work in _init())
onready var difficulty = get_parent().get_parent().current_difficulty
#Reference to Timeout
onready var time_bar = get_parent().get_parent().get_node("game_timer").get_node("ProgressBar")

func _ready():
	print("Difficulty level: "+str(difficulty))
	#Configures initial values for timer
	time_bar.set_max(DURATION)
	time_bar.set_value(DURATION)
	pass

func _process(delta):
	#Call timer update function
	update_timer(delta)
	pass

#This method is called right after the minigame starts being playable
func start():
	#Turns on the game loop
	set_process(true)
	#Show the timer bar
	time_bar.show()
	pass

#This method is called after the minigame is won or lost
func stop():
	#Turns off the game loop
	set_process(false)
	#Hide the timer bar
	time_bar.hide()
	pass

#Updates the timer bar values
func update_timer(delta):
	#Updates remaining time for the minigame
	var time_percentage = time_bar.get_value()-delta
	time_bar.set_value(time_percentage)
	#Check if time ran out
	if time_percentage <= 0:
		#End minigame by timeout
		emit_signal("minigame_end", TIMEOUT_WIN)
	pass
