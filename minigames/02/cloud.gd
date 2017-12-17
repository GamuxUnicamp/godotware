extends Node2D

# Reference to drop scene
var DROP_REF = preload("res://minigames/02/drop.tscn")
# Rain drops spawn speed in seconds
var drop_spawn_speed = 0.25
# Rain drop spawn point
var spawn_point = Vector2(0,50)
# Amount of variation in the x axis for drop spawning
var spawn_x_variation = 50

# Counter for time
var count

func _ready():
	count = 0
	set_process(true)
	pass

func _process(delta):
	#Update position according to mouse x axis
	set_pos(Vector2(get_viewport().get_mouse_pos().x, get_pos().y))
	#Update spawn timer
	count += delta
	if count >= drop_spawn_speed:
		#Reset timer and spawn new drop
		count = 0
		var drop = DROP_REF.instance()
		var x_variation = Vector2(rand_range(-spawn_x_variation, spawn_x_variation),0)
		drop.set_pos(get_pos() + spawn_point + x_variation)
		get_parent().add_child(drop)
	pass

# Stop handling touch
func stop():
	set_process(false)
	get_node("sprite").get_node("anim").stop()