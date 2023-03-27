extends Node2D

const MAX_POOL_SIZE = 10

var object_pool = []
var available_objects = []

func _ready():
	# Create the object pool
	for i in range(MAX_POOL_SIZE):
		var obj = preload("res://Scenes/Coin.tscn").instance()
		obj.set_visible(false)
		object_pool.append(obj)
		available_objects.append(obj)
	
	spawn_object($Node2D.position)

func spawn_object(position):
	
	var obj
	# Check if there are any available objects in the pool
	if available_objects.size() > 0:
		obj = available_objects.pop_front()
		obj.set_position(position)
		obj.set_visible(true)
	else:
		# No available objects, create a new one
		obj = preload("res://Scenes/Coin.tscn").instance()
		obj.set_position(position)
		obj.set_visible(true)
	
	# Add the object to the scene
	$Node2D.add_child(obj)

func despawn_object(obj):
	# Remove the object from the scene
	$Node2D.remove_child(obj)
	
	# Reset the object's properties
	obj.set_position(Vector2.ZERO)
	obj.set_visible(false)
	
	# Add the object back to the pool
	available_objects.append(obj)
