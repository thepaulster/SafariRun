extends Area2D



func _on_PlayerFall_body_entered(body):
	
	if body.is_in_group("player"):
		Signals.emit_signal("player_dead")
		
	if body.is_in_group("prey"):
		#Signals.emit_signal("prey_dead", body.get_position().x)
		Globals.prey_dead = 1
		Globals.flip = false
		print("player_fell")
		pass
