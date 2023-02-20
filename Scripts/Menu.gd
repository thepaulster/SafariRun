extends CanvasLayer


func _ready():
	get_tree().set_auto_accept_quit(false)
	pass

func _input(event):
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
	pass # Replace with function body.


func _on_ShopButton_pressed():
	get_tree().change_scene("res://Scenes/UI/Shop.tscn")
	pass # Replace with function body.

func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")


func _on_SettingsButton_pressed():
	get_tree().change_scene("res://Scenes/UI/Settings.tscn")
	pass # Replace with function body.
