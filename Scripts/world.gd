extends Node2D


signal level_changed(level_name)


export (String) var level_name = "level" 
onready var spawn_position = get_node("SpawnPosition")
#const hyena = preload("res://Scenes/Player.tscn")
#const lioness = preload("res://Scenes/lioness.tscn")
#const lion = preload("res://Scenes/lion.tscn")
#const leopard = preload("res://Scenes/Leopard.tscn")
#const cheetah = preload("res://Scenes/Cheetah.tscn")
const simpleplayer = preload("res://Scenes/simplePlayer.tscn")

#var selected_player = [
#				hyena, lioness, leopard, lion, cheetah
#	]

var hunter

func _ready():
	#hunter = selected_player[Globals.store.selected]
	hunter = simpleplayer
	_spawn_player()
	Signals.connect("change_level", self, "_level_change_func")


func _spawn_player():
	var player = hunter.instance()
	player.set_position(get_position())
	spawn_position.call_deferred("add_child", player)

func cleanup():
	queue_free()

func _level_change_func():
	emit_signal("level_changed", level_name)
