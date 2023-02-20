extends CanvasLayer

onready var pause_ovelay = get_node("pause_overlay")
onready var pause_button = get_node("PauseButton")
onready var music_button = get_node("pause_overlay/PauseMenu/VBoxContainer/HBoxContainer/Music")
onready var sound_button = get_node("pause_overlay/PauseMenu/VBoxContainer/HBoxContainer/Sound")

onready var distance_label = get_node("HUD/details/HBoxContainer/Distance")
onready var meat_label = get_node("HUD/details/HBoxContainer2/Meat")
onready var details_labels = get_node("HUD/details")

var distance_display = 0
var another = 0


func _ready():
	Globals.settings_load()
	#print(Globals.save_settings.music)
	another = Globals.keep_distance
	distance_label.text = str(Globals.keep_distance)
	meat_label.text = str(Globals.meat)
	
	music_button.pressed = Globals.save_settings.music #MusicController.mute
	sound_button.pressed = Globals.save_settings.sounds #SoundsController.mute
	
	Globals.connect("meat_collected", self, "_meat_update")
	Globals.connect("distance_changed", self, "_distance_update")
	Globals.connect("keep_distance", self, "_distance_kept")
	Signals.connect("player_dead", self, "_hide_HUD")
	pause_ovelay.visible = false
	#details_labels.visible = false
	get_tree().paused = false

func _input(event):
	
	if event.is_action_pressed("ui_cancel"):
		#var new_pause_state = !get_tree().paused
		#get_tree().paused = new_pause_state
		get_tree().paused = !get_tree().paused
		pause_ovelay.visible = !pause_ovelay.visible
		pause_button.visible = !pause_button.visible
		details_labels.visible = !details_labels.visible

func _on_PauseButton_pressed():
	get_tree().paused = true
	pause_ovelay.visible = true
	pause_button.visible = false
	details_labels.visible = false
	pass # Replace with function body.

func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			get_tree().paused = !get_tree().paused
			pause_ovelay.visible = !pause_ovelay.visible
			pause_button.visible = !pause_button.visible
			details_labels.visible = !details_labels.visible

func _on_Resume_pressed():
	get_tree().paused = false
	pause_ovelay.visible = false
	pause_button.visible = true
	details_labels.visible = true
	pass # Replace with function body.


func _on_Retry_pressed():
	Globals.meat = 0
	Globals.keep_distance = 0
	#Signals.emit_signal("resume_on_thatlevel")
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Home_pressed():
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
	pass # Replace with function body.

func _meat_update(value):
	meat_label.text = str(value)

func _distance_update(value):
	
	distance_display = another
	distance_display += value
	Globals.keep_distance = distance_display
	#distance_label.text = str(value)

func _distance_kept(value):
	distance_label.text = str(value)
	pass

func _hide_HUD():
		pause_button.visible = false
		details_labels.visible = false


func _on_Music_toggled(button_pressed):
	MusicController.music_player_status(button_pressed) 
	Globals.settings_save()
	#Globals.save_settings
	pass # Replace with function body.


func _on_Sound_toggled(button_pressed):
	Globals.sound_status(button_pressed)
	Globals.settings_save()
	#Globals.save_settings
	pass # Replace with function body.
