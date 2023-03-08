extends CanvasLayer

#onready var pause_ovelay = get_node("pause_overlay")
onready var pause_button = get_node("PauseButton")
#onready var music_button = get_node("pause_overlay/PauseMenu/VBoxContainer/HBoxContainer/Music")
#onready var sound_button = get_node("pause_overlay/PauseMenu/VBoxContainer/HBoxContainer/Sound")

onready var distance_label = get_node("HUD/details/HBoxContainer/Distance")
onready var meat_label = get_node("HUD/details/HBoxContainer2/Meat")
onready var HUD = get_node("HUD")

var distance_display = 0
var another = 0


func _ready():
	
	Signals.connect("resume", self, "_on_Resume_pressed")
	pass
	

func _on_PauseButton_pressed():
	
	Signals.emit_signal("pause")
	pause_button.visible = false
	HUD.visible = false


func _on_Resume_pressed():
	#get_tree().paused = false
	#pause_ovelay.visible = false
	if get_tree().paused == false:
		pause_button.visible = true
		HUD = true
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
