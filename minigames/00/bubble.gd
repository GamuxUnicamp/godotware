extends Node2D

# Reference to the splash animation
var SPLASH_REF = preload("res://minigames/00/bubble_splash.tscn")

var ABS_VEL = 250

var current_vel

func _ready():
	generate_vel()
	random_spawn()
	pass

func process(delta):
	translate(current_vel * delta)
	hit_border()
	pass

# Place the current bubble in a valid random position
func random_spawn():
	randomize()
	var min_pos = Vector2(0,0)
	var max_pos = get_lower_right_border()
	set_pos(Vector2(rand_range(min_pos.x, max_pos.x), rand_range(min_pos.y, max_pos.y)))

# Generates a random rotation and creates an unitary velocity vector for the bubble
func generate_vel():
	randomize()
	var rotation = randf() * 360
	var rad_rotation = deg2rad(rotation)
	var vec_sin = sin(rad_rotation)
	var vec_cos = cos(rad_rotation)
	current_vel = Vector2(ABS_VEL*vec_sin, ABS_VEL*vec_cos)
	pass

# Make bubble ricochet between borders
func hit_border():
	# Check for left border
	if (get_pos().x <= 0
	and current_vel.x < 0) :
		current_vel.x *= -1
	# Check for right border
	if (get_pos().x >= get_lower_right_border().x
	and current_vel.x > 0) :
		current_vel.x *= -1
	# Check for upper border
	if (get_pos().y <= 0
	and current_vel.y < 0) :
		current_vel.y *= -1
	# Check for lower border
	if (get_pos().y >= get_lower_right_border().y
	and current_vel.y > 0) :
		current_vel.y *= -1
	pass

# Get viewport lower right border limit
func get_lower_right_border():
	var border = get_viewport().get_visible_rect().size
	border -= get_node("sprite").get_size() + 2*get_node("sprite").get_pos()
	return border

# Instantiate the splash effect and remove bubble from scene
func pop():
	var splash = SPLASH_REF.instance()
	splash.set_pos(get_pos())
	get_parent().get_parent().add_child(splash)
	queue_free()
	pass

# Start handling touch
func start():
	get_node("sprite").connect("button_down", self, "pop")
	pass

# Stop handling touch
func stop():
	get_node("sprite").disconnect("button_down", self, "pop")