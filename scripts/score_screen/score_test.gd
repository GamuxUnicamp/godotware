extends Node2D

onready var score_text = get_node("score_text")
onready var best_score_text = get_node("best_score_text")

func _ready():
	score_text.set_text("Score: " + str(global.current_score))
	load_game()
	if global.selected_difficulty == 1:
		if global.current_score > global.high_score_easy:
			global.high_score_easy = global.current_score
			save_game()
			print("1 IF")
		best_score_text.set_text("Best Score: " + str(global.high_score_easy))
	elif global.selected_difficulty == 2:
		if global.current_score > global.high_score_easy:
			global.high_score_medium = global.current_score
			save_game()
		best_score_text.set_text("Best Score: " + str(global.high_score_medium))
	elif global.selected_difficulty == 3:
		if global.current_score > global.high_score_easy:
			global.high_score_hard = global.current_score
			save_game()
		best_score_text.set_text("Best Score: " + str(global.high_score_hard))
	elif global.selected_difficulty == 4:
		if global.current_score > global.high_score_easy:
			global.high_score_insane = global.current_score
			save_game()
		best_score_text.set_text("Best Score: " + str(global.high_score_insane))
	#print(global.current_score)
	global.current_score = 0

func _on_return_button_pressed():
	get_tree().change_scene("res://scenes/title_test.tscn")

func _on_try_again_button_pressed():
	get_tree().change_scene("res://scenes/session_lobby.tscn")

func load_game():
	var save_file = File.new()
	if save_file.file_exists("user://savegame.sav"):
		save_file.open("user://savegame.sav",File.READ)
		var save_data = save_file.get_var()
		global.high_score_easy = save_data["easy"]
		global.high_score_medium = save_data["medium"]
		global.high_score_hard = save_data["hard"]
		global.high_score_insane = save_data["insane"]
		save_file.close()

func save_game():
	var save_data = {"easy":global.high_score_easy, "medium":global.high_score_medium, "hard":global.high_score_hard, "insane":global.high_score_insane}
	var save_file = File.new()
	save_file.open("user://savegame.sav",File.WRITE)
	save_file.store_var(save_data)
	save_file.close()
