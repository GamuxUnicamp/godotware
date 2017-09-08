extends Node2D

#Minigame duration in seconds
var DURATION = 5.0
#Behaviour during timeouts
var TIMEOUT_WIN = false

#Difficulty Level (ranging from 1 to 10)
onready var difficulty = get_parent().get_parent().current_difficulty
#Reference to Timeout
onready var time_bar = get_parent().get_parent().get_node("game_timer").get_node("ProgressBar")

func _ready():
	time_bar.set_max(DURATION)
	time_bar.set_value(DURATION)
	pass

func _process(delta):
	update_timer(delta)
	pass


func start():
	set_process(true)
	time_bar.show()
	pass

func update_timer(delta):
	var time_percentage = time_bar.get_value()-delta
	time_bar.set_value(time_percentage)
	if time_percentage <= 0:
		#End minigame by timeout
		emit_signal("minigame_end", TIMEOUT_WIN)
	pass

func stop():
	set_process(false)
	time_bar.hide()
	pass
