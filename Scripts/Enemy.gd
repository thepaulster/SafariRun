extends KinematicBody2D

export var speed = 400
export var jumpforce = 1600
export var gravity = 4500

var velocity = Vector2()
var invul = false

func _ready():
	$AudioStreamPlayer.play()
	Signals.connect("invulnerable", self, "_set_invulnerability")

func _physics_process(delta):
	velocity.x = -speed
	
	velocity.y += gravity * delta
	velocity.y = move_and_slide(velocity, Vector2.UP).y 
	pass


func _on_enemyarea_body_entered(body):
	if body.is_in_group("player") and invul == false:
		Signals.emit_signal("player_dead")

func _set_invulnerability(value): #complete invulnerability
	invul = value
