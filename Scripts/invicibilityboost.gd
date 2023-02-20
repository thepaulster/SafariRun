extends Area2D




func _on_invicibilityboost_body_entered(body):
	if body.is_in_group("player"):
		Signals.emit_signal("invulnerable", true)
		visible = false
		pass # Replace with function body.
