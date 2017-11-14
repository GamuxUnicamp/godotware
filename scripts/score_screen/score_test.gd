extends Node2D

onready var score_text = get_node("score_text")
onready var best_score_text = get_node("best_score_text")

func _ready():
	if global.last_session_data.score > global.best_scores["test"]:
		global.best_scores["test"] = global.last_session_data.score
	print(global.last_session_data.score)
	score_text.set_text("Score: " + str(global.last_session_data.score))
	best_score_text.set_text("Score: " + str(global.best_scores["test"]))
	pass

func _on_return_button_pressed():
	get_tree().change_scene("res://scenes/title_test.tscn")
	pass

func _on_try_again_button_pressed():
	get_tree().change_scene("res://scenes/session_lobby.tscn")
	pass
