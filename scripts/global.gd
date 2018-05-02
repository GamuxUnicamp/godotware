extends Node

# let's give'em better names!
var main_node setget , _get_main_node
var view_size setget , _get_view_size


func get_available_minigames():
	var minigames = []
	
	var dir = Directory.new()
	if dir.open("res://minigames/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir() and file_name != '..' and file_name != '.':
				print("Found minigame: " + file_name)
				minigames.append("res://minigames/"+file_name+"/Main.tscn")
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	return minigames

var last_session_data = {
	score = 0
}

var best_scores = {
	"test": 0
}

var selected_difficulty = 1

func _ready():
	pass


# Space Shooter Extras!

# return minigame's (not global) main node
func _get_main_node():
	var root = get_tree().get_root()
	return root.get_child( root.get_child_count()-1 ).get_node('microgame_pod').get_node('Main')

# gets viewport's size (width/height)
func _get_view_size():
	return get_tree().get_root().get_visible_rect().size

# given a list, returns a random element
func choose(choises):
	randomize()
	var rand_index = randi() % choises.size()
	return choises[rand_index]

# create timer in seconds!
func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer