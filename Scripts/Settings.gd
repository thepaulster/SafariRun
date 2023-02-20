extends CanvasLayer

onready var back_button = get_node("Control/Ui1/Control/BackButton")
onready var music_button = get_node("Control/Ui1/Control/VBoxContainer/HBoxContainer/MusicOn")
onready var sound_button = get_node("Control/Ui1/Control/VBoxContainer/HBoxContainer/SoundsOn")

func _ready():
	Globals.settings_load()
	music_button.pressed = Globals.save_settings.music #MusicController.mute
	#print(MusicController.mute)
	sound_button.pressed = Globals.save_settings.sounds
	pass # Replace with function body.

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/UI/Menu.tscn")
	pass # Replace with function body.

func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			get_tree().change_scene("res://Scenes/UI/Menu.tscn")

func _on_MusicOn_toggled(button_pressed):
	#MusicController.mute = button_pressed
	MusicController.music_player_status(button_pressed)
	Globals.settings_save()
	#print(MusicController.mute)
	pass # Replace with function body.

#soundtoggle 

func _on_SoundsOn_toggled(button_pressed):
	Globals.sound_status(button_pressed)
	Globals.settings_save()
	pass # Replace with function body.


func _on_CreditsBtn_pressed():
	get_tree().change_scene("res://Scenes/UI/Credits.tscn")
	pass # Replace with function body.
