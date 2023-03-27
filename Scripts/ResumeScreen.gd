extends Control

signal countdown(value)

onready var progress_timer = get_node("TextureProgress")
onready var resume_timer = get_node("ResumeTimer")

var _count = 5

func _ready():
	resume_timer.start()

func _on_timeout():
	emit_signal("countdown", _count)
	_count -= 1
	progress_timer.value -= 1
	if _count <= 0:
		resume_timer.stop()
		Signals.emit_signal("on_resume_timeout")


func _on_ResumeTimer_timeout():
	_on_timeout()
	pass # Replace with function body.
