extends Spatial

const SPEED = 2.0
const TURN_SPEED = 1.0
const DISTANCE_LIMIT = 2.0

onready var collided = false

signal collide

func _ready():
	set_fixed_process(true)
	get_node("Area").connect("area_enter", self, "_on_area_enter")

func _on_area_enter(area):
	if(collided):
		return
	collided = true
	get_node("AnimationPlayer").play("crash")
	emit_signal("collide")

func _fixed_process(delta):
	if(collided):
		if SPEED > 0:
			SPEED -= delta
	# Move car
	set_translation(get_translation() + Vector3(SPEED*delta,0,0))
	
	if(collided):
		return
	# Turn car
	var turn = Input.get_accelerometer().x
	set_translation(get_translation() + Vector3(0,0,-turn*TURN_SPEED*delta))
	get_node("Sprites/SpriteSteering").set_rotation_deg(Vector3(-turn*10,90,0))
	
	# Check for lateral collision
	if (get_translation().z < -DISTANCE_LIMIT):
		set_translation(Vector3(get_translation().x, get_translation().y, -DISTANCE_LIMIT))
	if (get_translation().z > DISTANCE_LIMIT):
		set_translation(Vector3(get_translation().x, get_translation().y, DISTANCE_LIMIT))
	