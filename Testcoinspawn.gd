extends Node2D

const coin = preload("res://Scenes/Meat.tscn")

onready var position1 = get_node("Position2D")
onready var position2 = get_node("Position2D2")

var rand = RandomNumberGenerator.new()
var spawn_postiion = []
var randomspawn

func _ready():
	rand.randomize()
	spawn_postiion = [position1.get_position(), position2.get_position()]
	randomspawn = rand.randi_range(0, 1)
	spawn_coins()


func spawn_coins():
	var new_coin = coin.instance()
	new_coin.position = spawn_postiion[randomspawn]
	call_deferred("add_child", new_coin)
