extends Node

func _ready():
	pass

func _on_return_button_pressed():
	get_tree().change_scene("res://scenes/title_test.tscn")
	pass

func _on_try_again_button_pressed():
	get_tree().change_scene("res://scenes/session_lobby.tscn")
	pass
