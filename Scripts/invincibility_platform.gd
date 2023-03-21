extends StaticBody2D

onready var dash_platform = get_node("CollisionShape2D")


func _ready():
	dash_platform.disabled = true
	
	Signals.connect("dashing_now", self, "enable_dash_platform")
	Signals.connect("dash_ended", self, "disable_dash_platform")
	pass # Replace with function body.

func enable_dash_platform():
	dash_platform.disabled = false
	

func disable_dash_platform():
	dash_platform.disabled = true
