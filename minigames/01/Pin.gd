extends Sprite


onready var vel = Vector2(0.0,0.0)
onready var is_flying = false

func on_area_enter(area):
	if area.get_parent().is_in_group("player"):
		get_node("Area2D").set_enable_monitoring(false)
		fly()
		set_process(true)

func positionate(difficulty):
	if difficulty == 1: #EASY
		set_pos(Vector2(195, 250))
		set_scale(Vector2(.95, .95))
		return
	elif difficulty == 2: #MEDIUM
		set_pos(Vector2(195,130))
		set_scale(Vector2(.75, .75))
		return
	elif difficulty == 3: #HARD
		set_pos(Vector2(195,70))
		set_scale(Vector2(.65,.65))
		return
	elif difficulty == 4: #INSANE
		randomize()
		set_pos(Vector2(rand_range(150,240),70))
		set_scale(Vector2(.65,.65))
		return 
	#NOT_DEFINED
	set_pos(Vector2(195,130))
	set_scale(Vector2(.75, .75))
	pass

func fly():
	get_parent().TIMEOUT_WIN = true
	is_flying = true
	vel = Vector2(randf()*10 - 5, -5)

func _ready():
	get_node("Area2D").connect("area_enter", self, "on_area_enter")
	pass

func _process(delta):
	set_rot(get_rot()+delta*10)
	set_pos(get_pos()+vel*delta*100)

func stop():
	set_process(false)
