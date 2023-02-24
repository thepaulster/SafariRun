extends Node

onready var current_level = get_node("test_world")#("DrySavannaLevel")

func _ready():
	#MusicController.play_game_music()
	current_level.connect("level_changed", self, "handle_level_changed")
	Signals.connect("resume_on_thatlevel", self, "_resume_on_level")
	
func handle_level_changed(current_level_name: String):
	var next_level
	var next_level_name: String
	
	match current_level_name:
		"world":#"DrySavannah":
			next_level_name = "World2"#"GreenSavannah"
		"World2":#"GreenSavannah":
			next_level_name = "world"#"DrySavanna"
		_:
			return
	
	next_level = load("res://Scenes/Level/"+next_level_name+".tscn").instance()
	add_child(next_level)
	next_level.connect("level_changed",  self, "handle_level_changed")
	current_level.cleanup()
	current_level = next_level

func _resume_on_level():
	#print(current_level)
	#current_level.get_tree().reload_current_scene()
	pass
#connect signal from resume, get current level.get_tree().reload_current_scene
