extends Area2D

#func _ready():
#	Signals.connect("player_location", self, "coins_attracted")

#var move_position
var meat_value = 1

func _on_Coin_body_entered(body):
	
	if body.is_in_group("player"):
		#queue_free()
		Globals.meat += meat_value
		$collected.play()
		visible = false


#func coins_attracted(value):
#	move_position = value

#func _process(delta):
#	var bodies = get_overlapping_areas()
#	for body in bodies:
#		if body.is_in_group("coin_magnet"):
#			position += (move_position - position)/10
			#print(value)
#	pass