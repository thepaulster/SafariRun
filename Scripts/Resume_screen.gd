extends CanvasLayer


onready var meat_display = get_node("Control/Displaymeat")
onready var useMeat_button = get_node("Control/VBoxContainer/UseMeat")

var add_meat 

func _ready():
	add_meat = Globals.value_for_resume * 1000
	useMeat_button.text = " or use "+str(add_meat)+" meat "
	button_check()
	Signals.connect("player_dead", self, "_game_over")
	Signals.connect("on_resume_timeout", self, "_hide_UI")


func _game_over():
	
	Globals.total_meat_collected(Globals.meat)
	#Globals.save_data.total_meat = Globals.meat
	$Control/countdowncircle/ResumeTimer.start()
	Globals.data_save()
	Globals.data_load()
	meat_display.text = str(Globals.save_data.total_meat)
	visible = true
	get_tree().paused = true

func _hide_UI():
	visible = false


func _on_EndRun_pressed():
	Signals.emit_signal("on_resume_timeout")
	visible = false
	pass # Replace with function body.


func _on_WatchAD_pressed():
	
	#place a rewarded ad here
	pass # Replace with function body

func button_check():
	if add_meat < 2000: 
		useMeat_button.disabled = true 
	else:
		useMeat_button.disabled = false
	


func _on_UseMeat_pressed():
	Globals.value_for_resume += 1
	
	get_tree().reload_current_scene()
	pass # Replace with function body.
