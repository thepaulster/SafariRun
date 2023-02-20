extends Area2D


func _on_speedBoost_body_entered(body):
	if body.is_in_group("player"):
		Signals.emit_signal("speed_boost")
		visible = false
	pass # Replace with function body.
