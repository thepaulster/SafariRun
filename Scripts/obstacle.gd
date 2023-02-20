extends Area2D

var invul = false

onready var thudSound = get_node("thudSound")

func _ready():
	Signals.connect("invulnerable", self, "_set_invulnerability")


func _on_obstacle_body_entered(body):
	if body.is_in_group("player") and invul == false:
		#thudSound.play()
		Signals.emit_signal("player_dead")
		#body.queue_free()
		#print("player_dead")

func _set_invulnerability(value): #complete invulnerability
	invul = value
