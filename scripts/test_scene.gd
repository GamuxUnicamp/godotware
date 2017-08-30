extends Node2D

var btn_start

func _ready():
	btn_start = get_node("button")
	btn_start.connect("pressed", self, "start_minigame")
	pass

func start_minigame():
	print("= START MINIGAME")
	# Instantiate Minigame
	var scene = load("res://minigames/00-bubble_smasher.tscn")
	get_node("minigame_handler")._start_minigame(scene)
	
func close_minigame(win):
	print("fecha carai")
	if win:
		print("ganhou")
	else:
		print("perdeu")
