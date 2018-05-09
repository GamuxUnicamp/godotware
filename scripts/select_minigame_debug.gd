extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var minigames = global.get_available_minigames()
	
	for m in minigames:
		var new_button = Button.new()
		new_button.set_text(m)
		get_node("ScrollContainer/VBoxContainer").add_child(new_button)
		new_button.connect("button_down", self, "on_click", [m])

func on_click(m):
	global.debug_minigame = m
	get_tree().change_scene("res://scenes/session_lobby_debug.tscn")