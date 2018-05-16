extends "res://scripts/minigame.gd"

# Feito por Henrique Finger Zimerman

#=== MINIGAME BOILERPLATE ===#

#-> Check inherited file scripts/minigame.gd for more details

# This signal is called when the minigame finishes

signal minigame_end(win)

var acabou_desgraca = false

var cabraCount = 0

var numCabras = 3

var resultado = false

func fim():
	get_node("EndTimer").start()
	get_node("Flowers").queue_free()
	get_node("Goats").queue_free()
	

func _on_perdeu():
	if acabou_desgraca == false:
		acabou_desgraca = true
		resultado = false
		get_node("End").set_animation("Lose")
		fim()
		
func _on_morreu():
	if acabou_desgraca == false:
		cabraCount += 1
		if cabraCount >= numCabras:
			acabou_desgraca = true
			resultado = true
			get_node("End").set_animation("Win")
			fim()
			
func _on_timeout():
	emit_signal("minigame_end", resultado)

func start():
	#Be sure to only enable minigame elements in this method.
	get_node("Aim").set_process(true)
	get_node("Aim").set_process_input(true)
	get_node("EndTimer").connect("timeout",self,"_on_timeout")
	for goat in get_node("Goats").get_children():
		goat.set_process(true)
		goat.connect("morreu", self, "_on_morreu")
		if difficulty == 1:
			DURATION = 5
			goat.defWait = 0.2
		elif difficulty == 2:
			DURATION = 5
			goat.defWait = 0.15
		elif difficulty == 3:
			DURATION = 5
			goat.defWait = 0.1
		else:
			DURATION = 5
			goat.defWait = 0.075
	for flowerbed in get_node("Flowers").get_children():
		for flower in flowerbed.get_children():
			flower.set_process(true)
			if flower.get_name() == "FinalFlower":
				flower.connect("perdeu", self, "_on_perdeu")
	
	.start()
	pass

func stop():
	#Be sure to disable active minigame elements in this method.
	.stop()
	pass