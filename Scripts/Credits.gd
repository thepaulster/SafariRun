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
func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			get_tree().change_scene("res://Scenes/UI/Settings.tscn")



func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/UI/Settings.tscn")
	pass # Replace with function body.
