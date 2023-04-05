extends Node

var progress = 1.0
var time_left = 4.0
var step = 0.02

func _ready():
	$Timer.wait_time = 0.02
	$Timer.start()

func _on_Timer_timeout():
	time_left -= $Timer.wait_time
	if time_left < 0:
		time_left = 0
		$Timer.stop()
		#emit a signal to kill the player
	progress = time_left / 10.0
	$ProgressBar.value = progress