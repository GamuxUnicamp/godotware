extends Node2D

# This signal is called when the minigame finishes
signal minigame_end(win)

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
var minigame_ref

func _ready():
	#Populate minigame references array
	minigame_ref = Array()
	minigame_ref.append(preload("res://minigames/00/00-bubble_smasher.tscn"))
	minigame_ref.append(preload("res://minigames/01/01-bowling.tscn"))
	minigame_ref.append(preload("res://minigames/02/02-flower_watering.tscn"))
	minigame_ref.append(preload("res://minigames/03/03-driver.tscn"))
	minigame_ref.append(preload("res://minigames/04/04-dog_frisbee.tscn"))
	#Open first minigame
	open_minigame()
	pass

#Initialize minigame
func open_minigame():
	#Delete minigame, if it still exists
	if(current_minigame):
		current_minigame.queue_free()
	#Instantiate random minigame
	randomize()
	var random_minigame = select_minigame()
	current_minigame = minigame_ref[random_minigame].instance()
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

# Returns a random non-repeated minigame index
func select_minigame():
	var value = int(rand_range(0,minigame_ref.size()))
	while value == last_minigame_index:
		value = int(rand_range(0,minigame_ref.size()))
	last_minigame_index = value
	return value

func _on_minigame_finished(win):
	end_minigame(win)
	#close_minigame()
	pass

func _on_animation_finished():
	start_minigame()
	pass
