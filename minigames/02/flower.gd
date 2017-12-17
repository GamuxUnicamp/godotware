extends Node2D

# Signal triggered when flower blossoms
signal flower_blossomed

# Number of drops in order to blossom
var DROPS_TO_TRANSFORM = 1
# State of the flower
var opened = false
# Animation node reference
onready var anim = get_node("sprite").get_node("anim")

# Counter for the gathered drops
var drop_count

func _ready():
	drop_count = 0
	pass

func _on_Area2D_area_enter( area ):
	#Checks if collision happened with a drop
	if area.get_parent().is_in_group("drops"):
		#Sum point
		drop_count += 1
		#Kill drop
		area.get_parent().queue_free()
		#Check if flower can blossom
		if drop_count >= DROPS_TO_TRANSFORM and opened == false:
			opened = true
			#Change animation
			anim.play("flower")
			#Call main method
			emit_signal("flower_blossomed")
	pass # replace with function body

# Stops flower's actions
func stop():
	set_process(false)
	get_node("sprite").get_node("anim").stop()