extends Node2D

### DON'T CHANGE THIS SCRIPT, ###
### COPY-PASTE THE CODE INTO  ###
### YOUR MICROGAME SCENE!     ###

signal game_finished # When game has finished

# Called by Lobby scene when creating the microgame
func init():
	pass

# Setup when the game starts
func start():
	set_fixed_process(true)
	get_node("TextureButton").connect("pressed", self, "_on_pressed")
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

# ------------------------------------------------
# Setup BEFORE the game starts
func _ready():
	get_node("TextureButton").set_pos(Vector2(randf()*640, randf()*400))
	pass

func _fixed_process(delta):
	pass

func _on_pressed():
	won()