extends Node

var progress = 0

func _ready():
	$Timer.wait_time = 0.05
	$Timer.start()

func _on_Timer_timeout():
	progress += 0.05 / 5
	$ProgressBar.value = progress
