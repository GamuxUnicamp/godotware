extends Node2D

# Duration of the rising animation in seconds.
var rising_vel = 0.25
# Reference values for dog result interpolation animation.
var initial_pos_y = 500
var final_pos_y = 185

# Reference to dog result's sprite.
onready var sprite = get_node("sprite")
# Reference to dog result's animation controller.
onready var anim = get_node("sprite/anim")
# Controls if the rising animation is active.
var active = false
# Sum of delta times for interpolation.
var sum_time = 0

func _ready():
	pass

func _process(delta):
	#Animate if result is active. 
	if active:
		#Sum delta time to our time counter.
		sum_time += delta
		#Interpolate position according to time.
		set_pos(Vector2(get_pos().x, 
			lerp(initial_pos_y, final_pos_y, sum_time/rising_vel)))
		#If interpolation finished, deactivate.
		if sum_time >= rising_vel:
			active = false
	pass

# Starts result showing by enabling nodes and initializing interpolation.
func show_result(success):
	active = true
	sum_time = 0
	sprite.show()
	if success:
		anim.play("happy")
	else:
		anim.play("sad")
	pass

# Enable update function.
func start():
	set_process(true)
	pass

# Disable update function.
func stop():
	set_process(false)
	pass