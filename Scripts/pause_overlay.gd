extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func remove_ovelay():
	queue_free()


func _on_Resume_pressed():
	Signals.emit_signal("resume")
	pass # Replace with function body.


func _on_Home_pressed():
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
	pass # Replace with function body.


func _on_Retry_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.
