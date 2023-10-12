# This script extends the Node2D class in the Godot game engine
extends Node2D

# An array to store objects in the object pool
var object_pool = []

# The number of objects to be stored in the object pool
var pool_size = 6

# The scene from which the objects in the object pool are created
var scenes_to_spawn = [preload("res://Scenes/Level/new_world.tscn"), preload("res://Scenes/Level/new_world.tscn"), preload("res://Scenes/Level/new_world.tscn"), preload("res://Scenes/Level/new_world.tscn"), preload("res://Scenes/Level/new_world.tscn")]
#var scenes_to_spawn = [preload("res://Scenes/World1/test_ground.tscn"), preload("res://Scenes/World1/test_ground.tscn"), preload("res://Scenes/World1/test_ground.tscn"), preload("res://Scenes/World1/test_ground2.tscn"), preload("res://Scenes/World1/test_ground3.tscn")]

# The offset for each spawned object
var spawn_offset = Vector2(100, 0)

# The constant width of the ground
const GROUND_WIDTH = 1920

# The offset to use when spawning new objects
var spawn_new_offset = Vector2(GROUND_WIDTH, 0)

# The previous position of the last spawned object
var previous_pos = Vector2(0,0)

# The current scene to be used for spawning
var current_scene_index = 0

var random_index = 0

# The function that is called when the script is ready to be executed
func _ready():
	#randomize()
	# Initialize the object pool by creating instances of the scene
	for i in range(pool_size):
		
		# Choose a random scene to create an instance of
		#var random_index = int(rand_range(0, scenes_to_spawn.size() - 1))
		
		var scene_to_spawn = scenes_to_spawn[random_index]
		#print(scenes_to_spawn[random_index])
		# Create an instance of the scene
		var obj = scene_to_spawn.instance()
		#print(random_index)
		# Name the object based on its index in the object pool
		obj.name = "object_" + str(i)
		#print(obj.name)
		# Add the object to the object pool
		object_pool.append(obj)
		

		# Connect the "off_screen" signal from the object to the pool_object function
		obj.connect("off_screen", self, "try_again")
		
		random_index += 1
		
		if random_index >= 5:
			break
	
	# Call the spawn_objects function to spawn two objects
	spawn_objects(6)
	

# The function to spawn the specified number of objects
func spawn_objects(count):
	#var previous_pos = Vector2()
	#object_pool.shuffle()

	# Iterate through the object pool and find unused objects
	for i in range(count):
		for obj in object_pool:
			# If an unused object is found
			if not obj.get_parent():
				# Remove the object from its current parent, if any
				var current_parent = obj.get_parent()
				if current_parent:
					current_parent.remove_child(obj)

				# Add it to the container node as a child
				obj.position = previous_pos 
				#$container.call_deferred("add_child", obj)
				$container.add_child(obj)

				# Update the previous position to the position of the newly spawned object
				previous_pos = obj.position + spawn_new_offset

				# Break the loop as the object has been spawned
				break

# The function to add an object back to the object pool
func pool_object(obj):
	# Remove the object from the scene
	$container.call_deferred("remove_child", obj)

	# Reset the object's position
	#obj.position = Vector2()	
# The function to be called when an object goes off screen


func try_again(obj):
	# Call the pool_object function to add the object back to the pool
	pool_object(obj)

	# Call the spawn_objects function to spawn a new object
	spawn_objects(1)
