extends Node2D

export (Array, PackedScene) var ground

var random_scene = RandomNumberGenerator.new()
var selected_scene_index = 0

const GROUND_WIDTH = 510#1020
const AMOUNT_TO_FILL_VIEW = 3

func _ready():
	Signals.connect("ground_destroyed", self, "spawn_and_move")
	randomize()
	
	for _i in range(AMOUNT_TO_FILL_VIEW):
		spawn_and_move()

func spawn_and_move():
	spawn_ground()
	go_next_pos()

func spawn_ground():
	random_scene.randomize()
	selected_scene_index = random_scene.randi_range(0, ground.size() - 1)
	var new_ground = ground[selected_scene_index].instance()
	
	new_ground.set_position(get_position())
	#new_ground.connect("destroyed", self, "spawn_and_move")
	get_node("container").call_deferred("add_child", new_ground)

func go_next_pos():
	set_position(get_position() + Vector2(GROUND_WIDTH, 0))
