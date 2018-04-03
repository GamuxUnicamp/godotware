tool
extends PopupPanel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("VBoxContainer/Button").connect("pressed", self, "_on_create_pressed")

func _on_create_pressed():
	var minigame_name = get_node("VBoxContainer/MinigameName/LineEdit").get_text()
	var instruction = get_node("VBoxContainer/Instruction/LineEdit").get_text()
	var duration = int(get_node("VBoxContainer/Duration/SpinBox").get_val())
	
	var minigame_folder = minigame_name.replace(" ","")
	
	# Setting up minigame folder
	var dir = Directory.new()
	if dir.open("res://minigames/") == OK:
		if(dir.file_exists("res://minigames/"+minigame_folder)):
			get_node("VBoxContainer/Out").set_text("Name already exists!")
			return
		dir.make_dir("res://minigames/"+minigame_folder)
	else:
		get_node("VBoxContainer/Out").set_text("Error creating folder!")
		return
	
	# Setting main scene and script
	var new_minigame = Node2D.new()
	new_minigame.set_name("Main")
	
	var minigame_script_copy = load("res://scenes/minigame_boilerplate/minigame_boilerplate.gd").duplicate()
	minigame_script_copy.set_name("Main.gd")
	ResourceSaver.save("res://minigames/"+minigame_folder+"/"+"Main.gd", minigame_script_copy)
	minigame_script_copy = load("res://minigames/"+minigame_folder+"/"+"Main.gd")
	
	new_minigame.set_script(minigame_script_copy)
	new_minigame.NAME = minigame_name
	new_minigame.INSTRUCTION = instruction
	new_minigame.DURATION = duration
	
	var packed = PackedScene.new()
	packed.pack(new_minigame)
	ResourceSaver.save("res://minigames/"+minigame_folder+"/"+"Main.tscn", packed)
	get_node("VBoxContainer/Out").set_text("Success!")