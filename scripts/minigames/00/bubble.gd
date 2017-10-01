extends Node2D

func _ready():
	get_node("sprite").connect("button_down", self, "pop")

func pop():
	queue_free()
	
