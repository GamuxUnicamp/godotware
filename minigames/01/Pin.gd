extends Sprite

onready var vel = Vector2(0.0,0.0)
onready var is_flying = false

func on_area_enter(area):
	if area.get_parent().is_in_group("player"):
		get_node("Area2D").set_enable_monitoring(false)
		fly()
		set_process(true)

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