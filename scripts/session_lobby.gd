extends Node2D

#This signal is called when the minigame finishes
signal minigame_end(win)

#Minigame being currently played
var current_minigame
#Reference to minigame pod
var minigame_pod
#Reference to minigame pod's transition animation
var anim_transition

var minigame_ref

func _ready():
	minigame_pod = get_node("microgame_pod")
	anim_transition = get_node("transition_animation")
	
	minigame_ref = preload("res://minigames/00-bubble_smasher.tscn")
	open_minigame()
	#set_fixed_process(true)
	pass

#Initialize minigame
func open_minigame():
	#Delete minigame, if it still exists
	if(current_minigame):
		current_minigame.queue_free()
	#Instantiate minigame
	current_minigame = minigame_ref.instance()
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
	print("SUTAATO")
	anim_transition.disconnect("finished", self, "_on_animation_finished")
	current_minigame.start()
	pass

#End minigame
func end_minigame(win):
	print("ANDO")
	current_minigame.stop()
	#Check for win status
	if win:
		print("ganhou")
	else:
		print("perdeu")
	#Start animation
	anim_transition.play("game_end")
	anim_transition.connect("finished", self, "close_minigame")
	pass

#Close minigame
func close_minigame():
	minigame_pod.remove_child(current_minigame)
	print("FIM")
	pass





func _on_minigame_finished(win):
	end_minigame(win)
	#close_minigame()
	pass

func _on_animation_finished():
	start_minigame()
	pass