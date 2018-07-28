extends "res://scripts/minigame.gd"

#=== MINIGAME BOILERPLATE ===#
#-> Check inherited file scripts/minigame.gd for more details
# This signal is called when the minigame finishes
signal minigame_end(win)

var color_order = []
var color_order_input = []

func _ready():
	#= MINIGAME SETUP =#
	DURATION = 4 + difficulty*0.6 # 4 seconds + 0.6 seconds for every dificulty level
	for i in range(1,difficulty+3):
		randomize()
		color_order.append(randi()%4+1)
	#print(color_order)
	get_node("ButtonGreen").connect("button_down", self, "button_color_click",[1])
	get_node("ButtonRed").connect("button_down", self, "button_color_click",[2])
	get_node("ButtonYellow").connect("button_down", self, "button_color_click",[3])
	get_node("ButtonBlue").connect("button_down", self, "button_color_click",[4])

	#The command 'set_process(true)' is already called on base class _ready() function. It's not necessary to use it again.

func _process(delta):
	#This is the main game loop. Implement your main mechanics here
	#To finish the game with a victory, use:
	#		emit_signal("minigame_end", true)
	#To finish the game with a defeat, use:
	#		emit_signal("minigame_end", false)
	#Be wary that timeouts may trigger defeat by default. You can change that by tweaking with TIMEOUT_WIN variable in setup
	pass

func start():
	#Be sure to only enable minigame elements in this method.
	.start()
	for i in range(color_order.size()):
		var timer = Timer.new()
		if color_order[i] == 1:#GREEN
			timer.connect("timeout",self,"play_green")
		elif color_order[i] == 2:#RED
			timer.connect("timeout",self,"play_red")
		elif color_order[i] == 3:#YELLOW
			timer.connect("timeout",self,"play_yellow")
		elif color_order[i] == 4:#BLUE
			timer.connect("timeout",self,"play_blue")
		timer.set_wait_time(0.5*i+0.1)#the "+0.1" is beacause timers with wait_time = 0 will not run
		timer.set_one_shot(true)
		add_child(timer) #to process
		timer.start() #to start

func stop():
	#Be sure to disable active minigame elements in this method.
	.stop()

func button_color_click(color):
	color_order_input.append(color)
	if color == 1:#GREEN
		play_green()
	elif color == 2:#RED
		play_red()
	elif color == 3:#YELLOW
		play_yellow()
	elif color == 4:#BLUE
		play_blue()
	#compare input list with generated list
	if(color_order_input.size() > color_order.size()):
		emit_signal("minigame_end", false)
	else:
		for i in range(color_order_input.size()):
			if color_order_input[i] != color_order[i]:
				emit_signal("minigame_end", false)
		if color_order_input.size() == color_order.size():
			emit_signal("minigame_end", true)

func play_green():
	get_node("SamplePlayer").play("green") #play sound
	get_node("ButtonGreen/AnimationPlayer").play("AnimationGreen") #play animation

func play_red():
	get_node("SamplePlayer").play("red")
	get_node("ButtonRed/AnimationPlayer").play("AnimationRed")

func play_yellow():
	get_node("SamplePlayer").play("yellow")
	get_node("ButtonYellow/AnimationPlayer").play("AnimationYellow")

func play_blue():
	get_node("SamplePlayer").play("blue")
	get_node("ButtonBlue/AnimationPlayer").play("AnimationBlue")
	
