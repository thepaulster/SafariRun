extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_tree().paused = false


func _input(event):
	
	if event.is_action_pressed("ui_cancel"):
		#var new_pause_state = !get_tree().paused
		#get_tree().paused = new_pause_state
		get_tree().paused = !get_tree().paused
		#pause_ovelay.visible = !pause_ovelay.visible
		#pause_button.visible = !pause_button.visible

func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			get_tree().paused = !get_tree().paused
			#pause_ovelay.visible = !pause_ovelay.visible
			#pause_button.visible = !pause_button.visible
			#details_labels.visible = !details_labels.visible
