extends CanvasLayer

#onready var pause_ovelay = get_node("pause_overlay")
onready var pause_button = get_node("PauseButton")
#onready var music_button = get_node("pause_overlay/PauseMenu/VBoxContainer/HBoxContainer/Music")
#onready var sound_button = get_node("pause_overlay/PauseMenu/VBoxContainer/HBoxContainer/Sound")

onready var distance_label = get_node("HUD/details/HBoxContainer/Distance")
onready var meat_label = get_node("HUD/VBoxContainer/HBoxContainer/Label")
onready var HUD = get_node("HUD")

onready var test_meat = get_node("HUD/VBoxContainer/HBoxContainer/Label")
onready var test_label = get_node("HUD/VBoxContainer/HBoxContainer3/Label")

var distance_display = 0
var another = 0


func _ready():
	another = Globals.keep_distance
	Globals.connect("distance_changed", self, "_distance_update")#updates the distance ran by player
	Globals.connect("meat_collected", self, "_meat_update")#updates the meat collected by the player
	Globals.connect("keep_distance", self, "_distance_kept")
	Signals.connect("resume", self, "_on_Resume_pressed")#called when the player resumes the game
	Signals.connect("player_dead", self, "_hide_HUD") #called when the player dies to hide the HUD
	
	
	print(distance_display)

func _on_PauseButton_pressed():# called when the pause button is pressed
	
	Signals.emit_signal("pause")
	pause_button.visible = false
	HUD.visible = false

func _on_Resume_pressed():
	#if get_tree().paused == false:
	pause_button.visible = true
	HUD.visible = true
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
	#Globals.keep_distance = distance_display
	#print(value)
	distance_label.text = str(distance_display)
	test_label.text = str(distance_display)

func _distance_kept(value):
	distance_label.text = str(value)
	test_label.text = str(value)
	#print(distance_display)
	#print(value)
	pass

func _hide_HUD():
		pause_button.visible = false
		HUD.visible = false
		#details_labels.visible = false


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
