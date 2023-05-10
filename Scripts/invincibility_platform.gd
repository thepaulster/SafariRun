extends StaticBody2D

onready var dash_platform = get_node("CollisionShape2D")


func _ready():
	dash_platform.disabled = true
	
	Signals.connect("dashing_now", self, "enable_dash_platform")
	Signals.connect("powerup_bar_hide", self, "disable_dash_platform")
	pass # Replace with function body.

func enable_dash_platform():
	dash_platform.disabled = false #change to call_deferred() or set_deferred, check online for a solution
	

func disable_dash_platform():
	dash_platform.disabled = true
