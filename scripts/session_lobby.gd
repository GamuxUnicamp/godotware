extends Node2D

# Increase whole session's velocity
var increase_world_velocity = true

# Minigame being currently played
var current_minigame
# Reference to minigame pod
onready var minigame_pod = get_node("microgame_pod")
# Reference to minigame pod's transition animation
onready var anim_transition = get_node("transition_animation")
# Reference to minigame command label
onready var command_label = get_node("command_label")
# Reference to life meter's handler
onready var life_meter = get_node("life_meter")

# Tracks if a minigame is currently runnning
var is_minigame_running = false
# Current minigame's difficulty
var current_difficulty = global.selected_difficulty
# Max number of lives
var max_lives = 3
# Number of won minigames
onready var won_minigames = 0
# Number of lost minigames
onready var lost_minigames = 0
# Holds the index of the last played minigame to avoid repetitions
onready var last_minigame_index = -1
# Holds all minigame references for the current session
onready var minigame_ref = []
onready var minigame_ref_ind = []
# Check if finished minigame
onready var minigame_finished = false


func _ready():
	randomize()
	#Populate minigame references array
	var minigame_ref_string = global.get_available_minigames()
	for s in minigame_ref_string:
		minigame_ref.append(load(s))
	_shuffle_minigame_ref_ind()
	#Open first minigame
	open_minigame()
	pass

func _shuffle_minigame_ref_ind():
	minigame_ref_ind = range(minigame_ref.size())
	for i in range(minigame_ref_ind.size()):
		var ti = minigame_ref_ind[i]
		var ri = randi()%minigame_ref_ind.size()
		minigame_ref_ind[i] = minigame_ref_ind[ri]
		minigame_ref_ind[ri] = ti

#Initialize minigame
func open_minigame():
	#Delete minigame, if it still exists
	if(current_minigame):
		current_minigame.queue_free()
	
	if(minigame_ref_ind.size() == 0):
		_shuffle_minigame_ref_ind()
	current_minigame = minigame_ref[minigame_ref_ind[0]].instance()
	minigame_ref_ind.pop_front()
	current_minigame.translate(-get_viewport_rect().size/2)
	minigame_pod.add_child(current_minigame)
	#Listen to minigame's end
	current_minigame.connect("minigame_end",self,"_on_minigame_finished")
	#Changed command label
	command_label.set_text(current_minigame.INSTRUCTION)
	command_label.show()
	#Start animation
	anim_transition.play("game_intro")
	anim_transition.connect("finished", self, "_on_animation_finished")
	pass

#Starts minigame
func start_minigame():
	print("Start Microgame!")
	minigame_finished = false
	#Hide command label
	command_label.hide()
	#Add signal
	anim_transition.disconnect("finished", self, "_on_animation_finished")
	#Set minigame as running
	is_minigame_running = true
	#Start minigame
	current_minigame.start()
	pass

#End minigame
func end_minigame(win):
	print("End Microgame!")
	is_minigame_running = false
	current_minigame.stop()
	#Check for win status
	if win:
		print("You Win!")
		won_minigames += 1
		#If checked
		if increase_world_velocity:
			OS.set_time_scale(1 + won_minigames*0.1) # Gotta go fast!
	else:
		print("You Lose!")
		lost_minigames += 1
		update_life_meter()
	#Start animation
	anim_transition.play("game_end")
	anim_transition.connect("finished", self, "close_minigame")
	pass

#Close minigame
func close_minigame():
	#Remove signal
	anim_transition.disconnect("finished", self, "close_minigame")
	#Remove from scene
	minigame_pod.remove_child(current_minigame)
	if lost_minigames >= max_lives:
		print("FINISH!")
		print(won_minigames)
		end_session()
	open_minigame() #Will be removed
	pass

#End session
func end_session():
	global.last_session_data.score = won_minigames
	print(global.last_session_data.score)
	OS.set_time_scale(1)
	get_tree().change_scene("res://scenes/score_test.tscn")
	pass

#Update time meter
func update_life_meter():
	if lost_minigames >= 1:
		life_meter.get_node("life1").hide()
	if lost_minigames >= 2:
		life_meter.get_node("life2").hide()
	if lost_minigames >= 3:
		life_meter.get_node("life3").hide()
	pass

func _on_minigame_finished(win):
	if not minigame_finished:
		minigame_finished = true
		end_minigame(win)

func _on_animation_finished():
	start_minigame()