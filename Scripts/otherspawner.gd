extends Node2D

signal bigger_prey


#var prey_scene = preload("res://Scenes/Prey.tscn")
var prey_scene = preload("res://Scenes/asset_scenes/boar-test.tscn")
var prey_bigger_scene = preload("res://Scenes/Prey.tscn")

var prey_distance = Vector2(0, 0)

var spawn_position
var prey
var bigger_prey
var boar_count = 0


var start_position



func _ready():
	start_position = Vector2(0,0)
	print(start_position)
	_spawn_prey(1)
	
	Signals.connect("test", self, "_spawn_prey")
	connect("bigger_prey", self, "_spawn_bigger_prey")

func _spawn_prey(value):
	
	start_position = Globals.player_distance
	
	
	spawn_position = start_position + Vector2(600, 0) #400
	
	prey = prey_scene.instance()
	prey.position = spawn_position
	call_deferred("add_child", prey)
	
	boar_count += 1
	if boar_count == 4:
		_spawn_bigger_prey(1)
	elif boar_count >=5:
		boar_count = 0

func _spawn_bigger_prey(value):
	print("bigger prey")
	start_position = Globals.player_distance
	
	
	spawn_position = start_position + Vector2(800, 0) #400
	
	bigger_prey = prey_bigger_scene.instance()
	bigger_prey.position = spawn_position
	call_deferred("add_child", bigger_prey)
