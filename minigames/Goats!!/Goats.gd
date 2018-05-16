extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var defWait = 0.2


var alive = true
var waitTime = defWait+(randf()*defWait/10)
var timer = 0
var sprite = 0

signal morreu

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func die():
	if alive:
		get_node("Sprite").set_frame(2)
		alive = false
		emit_signal("morreu")

func _process(delta):
	if alive:
		timer += delta
		if timer >= waitTime:
			timer = 0
			waitTime = defWait+(randf()*defWait/10)
			move(Vector2(25,0))
			if sprite == 0:
				sprite = 1
				get_node("Sprite").set_frame(1)
			elif sprite == 1:
				sprite = 0
				get_node("Sprite").set_frame(0)