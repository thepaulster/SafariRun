extends Node2D

signal level_changed(level_name)

export (String) var level_name = "level" 

func cleanup():
	queue_free()

func _on_ChangeSceneButton_pressed():#hange to a distace of 1500 ran
	emit_signal("level_changed", level_name)
