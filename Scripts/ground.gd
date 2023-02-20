extends Node2D

signal destroyed
signal off_screen

func _ready():
	#visible = false
	pass

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("destroyed")
	emit_signal("off_screen", self)
	Signals.emit_signal("ground_destroyed")
	#queue_free()


func _on_VisibilityNotifier2D_screen_entered():
	visible = true
