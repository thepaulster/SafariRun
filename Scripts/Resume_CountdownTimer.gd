extends Control

onready var resume_timer = get_node("ResumeTimer")
onready var resume_label = get_node("resume_label")
onready var resume_tween = get_node("Resume_Tween")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var resume_count


# Called when the node enters the scene tree for the first time.
func _ready():
	resume_count = 5
	resume_label.text = str(resume_count)
	pass # Replace with function body.



func _on_ResumeTimer_timeout():
	resume_count -= 1
	resume_label.text = str(resume_count)
	if resume_count != 0:
		resume_timer.start()
	else:
		resume_timer.stop()
		resume_label.text = "start"
		resume_tween.interpolate_callback(self, 1, "visibility_func")
		resume_tween.start()
		#visible = false
	pass # Replace with function body.

func visibility_func():
	visible = false
