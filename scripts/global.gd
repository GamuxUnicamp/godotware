extends Node

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
