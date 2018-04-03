tool
extends Button

onready var PopupLoader = preload("res://addons/add_minigame_button/CreatePanel.tscn")

func _ready():
	connect("pressed", self, "_on_pressed")

func _on_pressed():
	print("OI")
	var popup = PopupLoader.instance()
	add_child(popup)
	popup.popup()
