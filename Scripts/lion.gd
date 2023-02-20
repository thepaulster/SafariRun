extends "res://Scripts/Player.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = load("res://Assets/Player Assets/lion/lions2.png")
	run = "lionrun"
	jump = "lionjump"
	fall = "lionfall"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
