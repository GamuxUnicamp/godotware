extends Node

func _ready():
	pass

func start_game_test():
	get_tree().change_scene("res://scenes/session_lobby.tscn")

func _on_start_button_pressed(): #_pressed
	start_game_test()
	pass 
