extends Node2D

# Signal triggered when frisbee is catch or is missed.
signal frisbee_catch(success)

# References to dog player's elements.
onready var anim = get_node("sprite/anim")

func _process(delta):
	#Update position according to mouse x axis (do not bypass the dog owner).
	set_pos(Vector2(min(get_viewport().get_mouse_pos().x, 500), get_pos().y))
	pass

func _on_Area2D_area_enter( area ):
	#Check for collision with frisbee.
	if area.get_parent().is_in_group("frisbee"):
		#Disables both dog and frisbee and send win signal.
		set_process(false)
		area.get_parent().set_process(false)
		emit_signal("frisbee_catch", true)
	pass 

func start():
	set_process(true)
	anim.play("running")
	pass

func stop():
	set_process(false)
	pass