extends Node

var progress = 1.0
var max_time = 25.0
var time_left = 25.0
var step = 0.02

var another_value = 0

onready var powerup = get_node("powerupbar")
onready var glow = get_node("Glow")


var run

#just add time left when player is captured

func _ready():
	$Timer.wait_time = 0.02
	$Timer.start()
	
	Signals.connect("add_stamina", self, "_stamina_added")
	Signals.connect("powerupcharge", self, "_power_up")
	Signals.connect("pause", self, "_pause_and_hide")
	Signals.connect("resume", self, "_resume_pressed")
	Signals.connect("powerup_used", self, "_power_up_visibility")
	#glow.visible = false

func _on_Timer_timeout():
	time_left -= $Timer.wait_time
	if time_left < 0:
		time_left = 0
		$Timer.stop()
		#emit a signal to kill the player
		Signals.emit_signal("player_stamina_empty")
		
	progress = time_left / 25.0
	$TextureProgress.value = progress


func _stamina_added(value):
	time_left += value #cap the time left to maximum time allowed by bar
	
	if time_left > max_time:
		time_left = max_time #caps max time of bar 

func _power_up(value):
	powerup.value += value
	
	if powerup.value >= powerup.max_value:
		#glow.visible = true
		Globals.powerupready = true
	else:
		#glow.visible = false
		pass
 
func _pause_and_hide():
	$Timer.paused = true
	$".".visible = false

func _resume_pressed():
	$Timer.paused = false
	$".".visible = true

func _power_up_visibility():
	powerup.value = 0
	glow.visible = false
