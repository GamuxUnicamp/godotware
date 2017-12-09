extends Sprite

onready var bowling = false
onready var is_pressed = false

onready var vel = Vector2(0,0)
onready var counter = 0.0

func bowl():
	bowling = true
	is_pressed = false

func _ready():
	add_to_group("player")
	get_node("Area2D").connect("input_event", self, "on_input_event")
	set_process(true)
	pass

func on_input_event(viewport, event, shape_idx):
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed and !bowling:
			is_pressed = true
		elif (!event.pressed and is_pressed):
			bowling = true
			is_pressed = false
	if event.type == InputEvent.SCREEN_DRAG:
		if is_pressed:
			vel = Vector2(event.x - get_global_pos().x, event.y - get_global_pos().y)*10
			set_global_pos(Vector2(event.x, event.y))

func _process(delta):
	if (bowling):
		counter += delta
		set_global_pos(get_global_pos()+vel*delta)
		set_frame(int(counter*12.0)%8)