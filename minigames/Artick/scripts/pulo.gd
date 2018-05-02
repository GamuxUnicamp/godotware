extends Area2D
var a = ""
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_fixed_process(true)# Called every time the node is added to the scene.
	# Initialization here
	pass
func _fixed_process(delta):
	a = get_overlapping_bodies()
	for i in range(a.size()):
		if a[i].get_name() == "ground" or a[i].get_name() == "platform1" or a[i].get_name() == "platform2":
			get_parent().velocidade_x = 0
			get_parent().velocidade = 0
			if Input.is_key_pressed(KEY_UP) and Input.is_key_pressed(KEY_LEFT):
				get_parent().velocidade -= 2.4
				get_parent().velocidade_x = -2
				pass
			if Input.is_key_pressed(KEY_UP) and Input.is_key_pressed(KEY_RIGHT):
				get_parent().velocidade -= 2.4
				get_parent().velocidade_x = 2
				pass
			if Input.is_key_pressed(KEY_UP) and (not Input.is_key_pressed(KEY_LEFT) or not Input.is_key_pressed(KEY_RIGHT)):
				get_parent().velocidade -=21
				pass
			if Input.is_key_pressed(KEY_LEFT):
				get_parent().move(Vector2(-5.4,0))
				pass
			if Input.is_key_pressed(KEY_RIGHT):
				get_parent().move(Vector2(5.4,0))
				pass
	pass