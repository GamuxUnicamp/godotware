extends "res://scripts/minigame.gd"

var CONE_SCENE = preload("res://minigames/03/Cone.tscn")

# This signal is called when the minigame finishes
signal minigame_end(win)

func _ready():
	#= MINIGAME SETUP =#
	#Setup for basic informations regarding your minigame. Check scripts/minigame.gd file for other configurable values
	NAME = "Hot Wheels"
	INSTRUCTION = "DRIVE!"
	DURATION = 5.0
	#You can also use the 'difficulty' variable, controlled by the Session, to tweak those values according to the difficulty
	#The difficulty may range from 1(EASY), 2(MEDIUM), 3(HARD) and 4(INSANE)
	print("This minigame has the difficulty level equal to "+str(difficulty))
	#The command 'set_process(true)' is already called on base class _ready() function. It's not necessary to use it again.
	init_stage()

func init_stage():
	var origin = get_node("3DViewportControl/Viewport/Origin")
	randomize()
	var distance_vector = [-1,0,1]
	for i in range(3):
		var z = randi()%distance_vector.size()
		var new_cone = CONE_SCENE.instance()
		new_cone.set_translation(Vector3((i+1)*2, 0, distance_vector[z]))
		distance_vector.remove(z)
		origin.add_child(new_cone)
		
		if (i == 0):
			var player = origin.get_node("PlayerCar")
			var pos = player.get_translation()
			pos.z = new_cone.get_translation().z
			player.set_translation(pos)
			
			player.connect("collide", self, "_on_collide")

func _on_collide():
	get_node("AnimationPlayer").play("background_crash")

func _process(delta):
	#This is the main game loop. Implement your main mechanics here
	#To finish the game with a victory, use:
	#		emit_signal("minigame_end", true)
	#To finish the game with a defeat, use:
	#		emit_signal("minigame_end", false)
	#Be wary that timeouts may trigger defeat by default. You can change that by tweaking with TIMEOUT_WIN variable in setup
	pass
