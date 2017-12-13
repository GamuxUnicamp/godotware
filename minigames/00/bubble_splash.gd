extends Node2D

# Time to die in seconds
var lifetime = 0.25

var lifecount

func _ready():
	lifecount = 0
	set_process(true)
	pass

func _process(delta):
	# Kill when lifetime ends
	lifecount += delta
	if lifecount >= lifetime:
		queue_free()
	pass