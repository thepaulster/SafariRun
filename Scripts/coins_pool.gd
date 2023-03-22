extends Node

var random_index = 0

var object_pool = []
var object_scene = preload("res://Scenes/Coin.tscn")

var scene_objects = [preload("res://Scenes/Coin.tscn"), preload("res://Scenes/Coin.tscn"), preload("res://Scenes/Coin.tscn")]

onready var spawn_node = get_node("Node2D")

func _ready():
	# Initialize the object pool with three instances of the object scene
	
	
	
	get_object()

func show_and_hide_objects():
	for i in range(3):
		var new_object = object_scene.instance()
		spawn_node.add_child(new_object)
		object_pool.append(new_object)
	# Hide all the objects in the pool
	for object in object_pool:
		object.hide()

func get_object():
	# Return the first available object in the pool, or create a new one if none are available
	for object in object_pool:
		if not object.visible:
			object.show()
			return object
	var scene_to_spawn = scene_objects[random_index]
	var new_object = scene_to_spawn.instance()
	spawn_node.add_child(new_object)
	object_pool.append(new_object)
	return new_object

func release_object(object):
	# Hide the object and return it to the pool
	object.hide()
