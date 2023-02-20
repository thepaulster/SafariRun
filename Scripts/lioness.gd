extends "res://Scripts/Player.gd"




# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = load("res://Assets/Player Assets/lioness/lioness3.png")
	run = "run"
	jump = "jump"
	fall = "fall"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
