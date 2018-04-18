extends "res://scripts/minigame.gd"

# Feito por Henrique Finger Zimerman

#=== MINIGAME BOILERPLATE ===#

#-> Check inherited file scripts/minigame.gd for more details

# This signal is called when the minigame finishes

signal minigame_end(win)

var acabou_desgraca = false

var cabraCount = 0

var numCabras = 3


func _on_perdeu():
	if acabou_desgraca == false:
		acabou_desgraca = true
		emit_signal("minigame_end", false)
		
func _on_morreu():
	if acabou_desgraca == false:
		cabraCount += 1
		if cabraCount >= numCabras:
			acabou_desgraca = true
			emit_signal("minigame_end", true)
		

func start():
	#Be sure to only enable minigame elements in this method.
	get_node("Aim").set_process(true)
	get_node("Aim").set_process_input(true)
	for goat in get_node("Goats").get_children():
		goat.set_process(true)
		goat.connect("morreu", self, "_on_morreu")
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