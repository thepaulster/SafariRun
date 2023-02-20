extends Node2D

#first import the admob script
var admob #= preload("res://admob.gd") 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	admob.init()
	
	admob.load_reward()
	
	admob.connect()
	pass # Replace with function body.

func _process(delta):
	if admob.is_reward_loaded():
		admob.show_reward()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
