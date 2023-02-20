extends Node


var gameplay_music = load("res://Assets/sounds/Waterworks.ogg")
var menu_music = load("res://Assets/sounds/trilinha4-tutti.ogg")

onready var music_player = get_node("music")

var mute = false setget music_player_status
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_game_music():
	music_player.stream = gameplay_music
	music_player.play()

func play_menu_music():
	music_player.stream = menu_music
	music_player.play()

func music_player_status(value):
	mute = value
	Globals.save_settings.music = value
	if value == false:
		music_player.volume_db = -20
	else:
		music_player.volume_db = -70
