extends Area2D

#func _ready():
#	Signals.connect("player_location", self, "coins_attracted")

#var move_position
var meat_value = 1

func _ready():
	Signals.connect("coin_visible", self, "_reset")

func _on_Coin_body_entered(body):
	
	if body.is_in_group("player"):
		#queue_free()
		Globals.meat += meat_value
		visible = false

func _reset():
	visible = true
	pass

#func coins_attracted(value):
#	move_position = value

#func _process(delta):
#	var bodies = get_overlapping_areas()
#	for body in bodies:
#		if body.is_in_group("coin_magnet"):
#			position += (move_position - position)/10
			#print(value)
#	pass


func _on_VisibilityNotifier2D_screen_entered():
	#Signals.emit_signal("coin_visible")
	pass # Replace with function body.
