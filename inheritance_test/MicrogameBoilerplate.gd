extends Node2D

### DON'T CHANGE THIS SCRIPT, ###
### COPY-PASTE THE CODE INTO  ###
### YOUR MICROGAME SCENE!     ###

signal game_finished # When game has finished

# Called by Lobby scene when creating the microgame
func init():
	pass

func start():
	# Setup the game when it starts
	set_fixed_process(true)
	pass

func stop():
	set_fixed_process(false)

func won():
	# Play some winning animation here!
	emit_signal("game_finished", true)
	pass

func lost():
	# Play some losing animation here!
	emit_signal("game_finished", false)

func _ready():
	pass

func _fixed_process(delta):
	pass