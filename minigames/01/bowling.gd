extends "res://scripts/minigame.gd"

#=== MINIGAME BOILERPLATE ===#

#-> Check inherited file scripts/minigame.gd for more details

# This signal is called when the minigame finishes
signal minigame_end(win)

func bowling_limit_area_enter(area):
	if area.get_parent().is_in_group("player"):
		get_node("Ball").bowl()

func wall_limit_area_enter(area):
	if area.get_parent().is_in_group("player"):
		get_node("Hole").set_pos(Vector2(get_node("Ball").get_pos().x, get_node("Hole").get_pos().y))
		get_node("Hole").show()
		get_node("Ball").hide()

func _ready():
	randomize()
	#= MINIGAME SETUP =#
	#Setup for basic informations regarding your minigame. Check scripts/minigame.gd file for other configurable values
	NAME = "Bowling"
	INSTRUCTION = "STRIKE IT!"
	DURATION = 3.0
	rotate_minigame()
	#You can also use the 'difficulty' variable, controlled by the Session, to tweak those values according to the difficulty
	print("This minigame has the difficulty level equal to "+str(difficulty))
	#The command 'set_process(true)' is already called on base class _ready() function. It's not necessary to use it again.
	
	get_node("BowlingLimit").connect("area_enter", self, "bowling_limit_area_enter")
	get_node("WallLimit").connect("area_enter", self, "wall_limit_area_enter")
	
	var scale = get_node("Ball").get_pos().y/(get_viewport().get_rect().size.x-200)
	get_node("Ball").set_scale(Vector2(scale, scale))

func _process(delta):
#	get_node("Ball").set_scale(Vector2(get_node("Ball").get_global_pos().x/(get_viewport().get_rect().size.x-300),get_node("Ball").get_global_pos().x/(get_viewport().get_rect().size.x-300)))
	var scale = get_node("Ball").get_pos().y/(get_viewport().get_rect().size.x-200)
	get_node("Ball").set_scale(Vector2(scale, scale))
	#This is the main game loop. Implement your main mechanics here
	#To finish the game with a victory, use:
	#		emit_signal("minigame_end", true)
	#To finish the game with a defeat, use:
	#		emit_signal("minigame_end", false)
	#Be wary that timeouts may trigger defeat by default. You can change that by tweaking with TIMEOUT_WIN variable in setup
	pass
