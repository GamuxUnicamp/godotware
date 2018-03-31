tool
extends EditorPlugin

var dock = null

func _enter_tree():
	# When this plugin node enters tree, add the custom type

	dock = preload("res://addons/add_minigame_button/add_minigame_button.tscn").instance()
	add_control_to_container(CONTAINER_CANVAS_EDITOR_MENU, dock)
	#add_control_to_dock( DOCK_SLOT_LEFT_UL, dock )

func _exit_tree():

	# Remove from docks (must be called so layout is updated and saved)
	remove_control_from_docks(dock)
	# Remove the node
	dock.free()




	
