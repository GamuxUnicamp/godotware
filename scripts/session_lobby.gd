extends Node2D

#This signal is called when the minigame finishes
signal minigame_end(win)

#Increase whole session's velocity
var increase_world_velocity = true

#Minigame being currently played
var current_minigame
#Reference to minigame pod
onready var minigame_pod = get_node("microgame_pod")
#Reference to minigame pod's transition animation
onready var anim_transition = get_node("transition_animation")
#Tracks if a minigame is currently runnning
var is_minigame_running = false
#Current minigame's difficulty
var current_difficulty = 4
#Max number of lives
var max_lives = 3
#Number of won minigames
onready var won_minigames = 0
#Number of lost minigames
onready var lost_minigames = 0

var minigame_ref

func _ready():
	minigame_ref = Array()
	minigame_ref.append(preload("res://minigames/00/00-bubble_smasher.tscn"))

	open_minigame()
	pass

#Initialize minigame
func open_minigame():
	#Delete minigame, if it still exists
	if(current_minigame):
		current_minigame.queue_free()
	#Instantiate minigame
	current_minigame = minigame_ref[0].instance()
	current_minigame.translate(-get_viewport_rect().size/2)
	minigame_pod.add_child(current_minigame)
	#Listen to minigame's end
	current_minigame.connect("minigame_end",self,"_on_minigame_finished")
	#Start animation
	anim_transition.play("game_intro")
	anim_transition.connect("finished", self, "_on_animation_finished")
	pass

#Starts minigame
func start_minigame():
	print("Start Microgame!")
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
	get_tree().change_scene("res://scenes/score_test.tscn")
	pass

func _on_minigame_finished(win):
	end_minigame(win)
	#close_minigame()
	pass

func _on_animation_finished():
	start_minigame()
	pass
