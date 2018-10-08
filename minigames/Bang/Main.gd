extends "res://scripts/minigame.gd"


# Feito por Arthur Lucas da Silva Nogueira
# feat. Henrique Finger Zimerman

#=== MINIGAME BOILERPLATE ===#

#-> Check inherited file scripts/minigame.gd for more details

# This signal is called when the minigame finishes
signal minigame_end(win)

var ready = false

var status = false

var end = false

	
func end():
	pause_timer()
	get_node("EndTimer").start()
	
func _ready():
	set_process(false)
	pass
	
func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON and end == false:
		end = true
		get_node("WaitTimer").stop()
		get_node("ShootTimer").stop()
		
		if ready == true:
			get_node("AnimatedSprite").set_animation("win")
			status = true
		else:
			get_node("AnimatedSprite").set_animation("dodge")
			status = false
		
		end()

func _process(delta):
	#This is the main game loop. Implement your main mechanics here
	#To finish the game with a victory, use:
	#		emit_signal("minigame_end", true)
	#To finish the game with a defeat, use:
	#		emit_signal("minigame_end", false)
	#Be wary that timeouts may trigger defeat by default. You can change that by tweaking with TIMEOUT_WIN variable in setup
	pass
	
func _on_end_timeout():
	emit_signal("minigame_end", status)

func _on_wait_timeout():
	ready = true
	get_node("AnimatedSprite").set_animation("ready")
	get_node("ShootTimer").start()
	
func _on_shoot_timeout():
	end = true
	ready = false
	get_node("AnimatedSprite").set_animation("bang")
	end()
	
	

func start():
	var shoot_time = 1.0
	if difficulty == 1:
		shoot_time = 1.0
	elif difficulty == 2:
		shoot_time = 0.75
	elif difficulty == 3:
		shoot_time = 0.5
	else:
		shoot_time = 0.3
	get_node("ShootTimer").set_wait_time(shoot_time)
	get_node("WaitTimer").set_wait_time((DURATION-shoot_time-1)*randf())
	get_node("ShootTimer").connect("timeout",self,"_on_shoot_timeout")
	get_node("WaitTimer").connect("timeout",self,"_on_wait_timeout")
	get_node("EndTimer").connect("timeout",self,"_on_end_timeout")
	get_node("WaitTimer").start()
	set_process(true)
	set_process_input(true)
	.start()
	pass

func stop():
	#Be sure to disable active minigame elements in this method.
	.stop()
	pass