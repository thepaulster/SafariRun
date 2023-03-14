extends Node


const pause_ovelay = preload("res://Scenes/UI/pause_overlay.tscn")
const ui_ovelay = preload("res://Scenes/UI/PauseMenu.tscn")
const end_resume = preload("res://Scenes/UI/Resume_screen.tscn")
const game_over = preload("res://Scenes/UI/EndScreen.tscn")

var node 
var overlay_node
var endscreen


# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_tree().paused = false
	screen_ovelay()
	
	Signals.connect("pause", self, "ovelay_stop")
	Signals.connect("resume", self, "resume_button")
	Signals.connect("player_dead", self, "play_continue")
	Signals.connect("on_resume_timeout", self, "_game_over")


func _input(event):
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		var new_instance = pause_ovelay.instance()
		
		if get_tree().paused == true:
			node = Node.new()
			add_child(node)
			node.add_child(new_instance)
		else:
			node.queue_free()
			
func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			get_tree().paused = !get_tree().paused
			var new_instance = pause_ovelay.instance()
		
			if get_tree().paused == true:
				node = Node.new()
				add_child(node)
				node.add_child(new_instance)
			else:
				node.queue_free()

func ovelay_stop():
	get_tree().paused = true
	var new_instance = pause_ovelay.instance()
		
	if get_tree().paused == true:
		node = Node.new()
		add_child(node)
		node.add_child(new_instance)

func screen_ovelay():
	var new_overlay = ui_ovelay.instance()
	
	overlay_node = Node.new()
	add_child(overlay_node)
	overlay_node.add_child(new_overlay)

func resume_button():
	get_tree().paused = false
	node.queue_free()

func play_continue():
	get_tree().paused = true
	var new_resume = end_resume.instance()
	
	if get_tree().paused == true:
		node = Node.new()
		add_child(node)
		node.add_child(new_resume)
	pass

func _game_over():
	
	pass
	
