extends Node

var progress = 1.0
var time_left = 5.0
var step = 0.02


#just add time left when player is captured

func _ready():
	$Timer.wait_time = 0.02
	$Timer.start()

func _on_Timer_timeout():
	time_left -= $Timer.wait_time
	if time_left < 0:
		time_left = 0
		$Timer.stop()
		#emit a signal to kill the player
		#Signals.emit_signal("player_stamina_empty")
	progress = time_left / 5.0
	$ProgressBar.value = progress
