extends Node2D

# Drop's falling speed
var fall_speed = 200

func _ready():
	set_process(true)
	pass

func _process(delta):
	#Update position
	set_pos(Vector2(get_pos().x, get_pos().y + fall_speed*delta))
	pass

func _on_Area2D_area_enter( area ):
	if area.get_parent().is_in_group("ground"):
		queue_free()
	pass # replace with function body
