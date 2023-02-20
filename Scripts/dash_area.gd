extends StaticBody2D

onready var dash_area = get_node("CollisionShape2D")
 
func _ready():
	#dash_area.disabled = true
	Signals.connect("dashing_now", self, "_dashing_enabled")
	Signals.connect("dash_ended", self, "_dashing_disabled")
	pass # Replace with function body.

func _dashing_enabled():
	dash_area.set_deferred("disabled", false) 
	
func _dashing_disabled():
	dash_area.set_deferred("disabled", true)
