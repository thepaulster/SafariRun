extends Node2D

var minus_speed = 10


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Signals.emit_signal("reduce_speed", minus_speed)
	pass # Replace with function body.


func _on_bush_body_entered(body):
	if body.is_in_group("player"):
		Signals.emit_signal("reduce_speed", minus_speed)
	pass # Replace with function body.
