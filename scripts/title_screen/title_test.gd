extends Node2D

onready var diffOptButton = get_node("difficulty_optbtn")

func _ready():
	diffOptButton.add_item("Easy")
	diffOptButton.add_item("Medium")
	diffOptButton.add_item("Hard")
	diffOptButton.add_item("Insane")

func start_game_test():
	get_tree().change_scene("res://scenes/session_lobby.tscn")

func _on_start_button_pressed(): #_pressed
	start_game_test()

func _on_difficulty_optbtn_item_selected( ID ):
	global.selected_difficulty = ID+1