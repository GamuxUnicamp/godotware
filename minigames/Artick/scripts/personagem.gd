extends KinematicBody2D
var velocidade = 0
var gravidade = 1
var pos = 0
var velocidade_x = 0
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_fixed_process(true)
	pass
func _fixed_process(delta):
	velocidade = velocidade + gravidade
	pos = get_pos().y
	move(Vector2(velocidade_x,velocidade))
	#if Input.is_key_pressed(KEY_LEFT):
	#	move(Vector2(-4,0))
	#	pass
	#if Input.is_key_pressed(KEY_RIGHT):
	#	move(Vector2(4,0))
	pass