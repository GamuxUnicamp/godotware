extends Node2D

# Signal triggered when frisbee is catch or is missed.
signal frisbee_catch(success)

# Peak parabola height.
var peak_height = 50
# Rotating speed in radians.
var rot_speed = 2

# Reference to frisbee's elements.
onready var sprite = get_node("sprite")

# Point descriptions for parabola initial, end and peak values.
var par_init
var par_end
var par_peak
# Coeficient descriptors for parabola: a, b and c (ax^2 +bx + c).
var coef_a = 0.0
var coef_b = 0.0
var coef_c = 0.0
# Time counter.
var par_time = 0
var time_count = 0


func _ready():
	par_init = get_pos()
	pass

# Calculates parabola (given 3 points) and enables movement.
func throw(p_endx, time):
	#Reset values.
	coef_a = 0.0
	coef_b = 0.0
	coef_c = 0.0
	#Get parabola points and duration. Peak point is the middle one between both same-y points.
	par_time = time
	par_end = Vector2(p_endx, par_init.y)
	par_peak = Vector2(par_end.x + (par_init.x - par_end.x)/2, peak_height)
	#We will apply a Lagrange Interpolation here. Firstly, get some dividers.
	var div_init = (par_init.x - par_peak.x)*(par_init.x - par_end.x)
	var div_peak = (par_peak.x - par_init.x)*(par_peak.x - par_end.x)
	var div_end = (par_end.x - par_init.x)*(par_end.x - par_peak.x)
	#Now get *a* coeficient.
	coef_a += par_init.y / div_init
	coef_a += par_peak.y / div_peak
	coef_a += par_end.y / div_end
	#Now get *b* coeficient.
	coef_b += (-par_init.y*(par_peak.x + par_end.x)) / div_init
	coef_b += (-par_peak.y*(par_init.x + par_end.x)) / div_peak
	coef_b += (-par_end.y*(par_init.x + par_peak.x)) / div_end
	#Now get *c* coeficient.
	coef_c += (par_init.y*par_peak.x*par_end.x) / div_init
	coef_c += (par_peak.y*par_init.x*par_end.x) / div_peak
	coef_c += (par_end.y*par_init.x*par_peak.x) / div_end
	#Enable moviment.
	time_count = 0
	set_process(true)
	pass

func _process(delta):
	#Rotate frisbee
	sprite.set_rot(sprite.get_rot() + rot_speed*delta)
	#Update timer
	time_count += delta
	#Lerp in x axis.
	var xval = lerp(par_init.x, par_end.x, time_count/par_time)
	#Interpolate parabola.
	set_pos(Vector2(xval, coef_a*xval*xval + coef_b*xval + coef_c))
	#Check if player lose.
	if time_count/par_time > 1.3:
		emit_signal("frisbee_catch", false)
		set_process(false)
		sprite.hide()
	#print(time_count/par_time)
	pass


# Enable update function.
func start():
	#set_process(true)
	pass

# Disable update function.
func stop():
	set_process(false)
	pass
