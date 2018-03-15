extends "res://scripts/minigame.gd"

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

	get_node("BowlingLimit").connect("area_enter", self, "bowling_limit_area_enter")
	get_node("WallLimit").connect("area_enter", self, "wall_limit_area_enter")

	var scale = get_node("Ball").get_pos().y/(get_viewport().get_rect().size.x-200)
	get_node("Ball").set_scale(Vector2(scale, scale))
	get_node("Pin").positionate(difficulty)

func _process(delta):
#	get_node("Ball").set_scale(Vector2(get_node("Ball").get_global_pos().x/(get_viewport().get_rect().size.x-300),get_node("Ball").get_global_pos().x/(get_viewport().get_rect().size.x-300)))
	var scale = get_node("Ball").get_pos().y/(get_viewport().get_rect().size.x-200)
	get_node("Ball").set_scale(Vector2(scale, scale))
	pass

func start():
	get_node("Ball").start()
	.start()

func stop():
	get_node("Ball").stop()
	get_node("Pin").stop()
	.stop()
