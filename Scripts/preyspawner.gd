extends Node2D

signal done

#var prey = preload("res://Scenes/Prey.tscn")
var prey = preload("res://Scenes/asset_scenes/boar-test.tscn")

var only_once = true
var timer_done = false
var prey_distance = Vector2(0, 0)
var count = 0

func _ready():
	#_spawn_prey()
	#_spawn_and_move(1)
	
	call_timer(1)
	Signals.connect("prey_caught", self, "call_timer")
	Signals.connect("prey_dead", self, "call_timer")
	Globals.connect("prey_done", self, "call_timer")

func call_timer(value):
	if Globals.flip:
		Globals.flip = false
		_spawn_prey()
		#_spawn_and_move(1)
	#$PreyTimer.start()
		


func _spawn_and_move(value):
	_spawn_prey()
	_go_next_pos()

func _spawn_prey():
	var new_prey = prey.instance()
	prey_distance = Globals.player_distance
	new_prey.set_position(prey_distance + Vector2(800, 0))
	$container.call_deferred("add_child", new_prey)
	#add_child(new_prey)
	
	#print(prey_distance)

func _spawn_more_prey():
	var new_prey = prey.instance()
	prey_distance = Globals.player_distance
	new_prey.set_position(prey_distance + Vector2(800, 0))
	call_deferred("add_child", new_prey)
	pass

func _go_next_pos():
	prey_distance = Globals.player_distance
	set_position(prey_distance  + Vector2(800, 0))

func _on_PreyTimer_timeout():
	_spawn_prey()
	pass # Replace with function body.
