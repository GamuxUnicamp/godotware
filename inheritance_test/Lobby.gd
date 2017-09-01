extends Node2D

const MAX_TIME = 5.0
const TIMER_STEP = 100.0/MAX_TIME
onready var Microgame = preload("res://inheritance_test/microgames/Microgame1.tscn")

onready var game_timer = get_node("GameTimer")

onready var is_game_playing = false # Is game playing
onready var game_counter = 0 # How many microgames played
onready var timer_multiplier = 1.0 # How fast the microgames will play
onready var current_game = null # Reference to current microgame

# Play the game!
func play_game():
	is_game_playing = true
	# Reset timer
	get_node("GameTimer").set_value(100.0)
	get_node("GameTimer").show()
	current_game.start()

# Stop the game!
func stop_game():
	is_game_playing = false
	get_node("GameTimer").hide()
	current_game.stop()

# Game finished; exit the lobby!
func exit_game():
	game_counter += 1
	OS.set_time_scale(1 + game_counter*0.1) # Gotta go fast!
	get_node("AnimationPlayer").play("game_after")

# Game enters lobby!
func enter_game():
	# Delete current game, if there was one
	if(current_game):
		current_game.queue_free()
	# Create game scene and transition
	current_game = Microgame.instance()
	current_game.connect("game_finished", self, "_on_game_finished")
	get_node("MicrogamePod").add_child(current_game)
	get_node("AnimationPlayer").play("game_intro")
	pass

func _ready():
	set_fixed_process(true)
	get_node("AnimationPlayer").connect("finished", self, "_on_animation_finished")
	enter_game()
	pass

func _fixed_process(delta):
	if (is_game_playing):
		game_timer.set_value(game_timer.get_value()-delta*TIMER_STEP)
	pass

func _on_animation_finished():
	if get_node("AnimationPlayer").get_current_animation() == "game_intro":
		play_game()
	elif get_node("AnimationPlayer").get_current_animation() == "game_after":
		enter_game()
	pass

func _on_game_finished(won):
	stop_game()
	exit_game()
	pass