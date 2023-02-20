extends CanvasLayer

signal progress_Signal

onready var progressbar = get_node("Control/ProgressBar")
onready var progressTimer = get_node("Control/Timer")
onready var Control_visibility = get_node("Control")

var maxvalue = 1
var minvalue = 0
var duration = 1

func _ready():
	Control_visibility.visible = false
	
	progressbar.max_value = duration
	progressbar.value = duration
	#print(progressbar.max_value)
	#print(Globals.powerUp_bar_value)
	progressTimer.wait_time = duration
	
	Signals.connect("powerup_bar_show", self, "bar_show")
	Signals.connect("powerup_bar_hide", self, "bar_hide")
	
	#progressbar.max_value = maxvalue
	pass

func bar_hide():
	Control_visibility.visible = false
	pass

func bar_show():
	Control_visibility.visible = true
	duration = Globals.powerUp_bar_value
	progressbar.max_value = duration
	progressbar.value = duration
	#print(progressbar.max_value)
	#print(duration)
	progressTimer.wait_time = 1
	progressTimer.start()
	
	#print(Globals.powerUp_bar_value)
	pass

func progress(duration):
	Control_visibility.visible = true
	#print(duration)
	#duration = Globals.powerUp_bar_value
	#print(Globals.powerUp_bar_value)
	progressbar.value = duration
	pass


func progress_timeout():
	emit_signal("progress_Signal")
	duration -= 1
	progressbar.value -= 1
	if duration <= 0:
		progressTimer.stop()
		pass
	pass

func _on_Timer_timeout():
	progress_timeout()
	pass # Replace with function body.
