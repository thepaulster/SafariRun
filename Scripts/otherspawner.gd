extends Node2D

var prey_scene = preload("res://Scenes/Prey.tscn")

var prey_distance = Vector2(0, 0)

var spawn_position
var prey

var start_position

func _ready():
	start_position = Globals.player_distance
	_spawn_prey(1)
	
	Signals.connect("test", self, "_spawn_prey")

func _spawn_prey(value):
	start_position = Globals.player_distance
	
	
	spawn_position = start_position + Vector2(400, 0)
	
	prey = prey_scene.instance()
	prey.position = spawn_position
	call_deferred("add_child", prey)
