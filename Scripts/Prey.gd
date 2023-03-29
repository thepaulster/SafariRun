extends KinematicBody2D

onready var jumpCast = get_node("jumpCast")

export var speed = 50
export var jumpforce = 1000
export var gravity = 1500

onready var animated_sprite = get_node("AnimatedSprite")

var velocity = Vector2()

var count = 0
var body_out = false

func _ready():
	Globals.flip = true
	#print("spawned1")
	pass

func _apply_jump():
	if jumpCast.is_colliding() and is_on_floor():
		velocity.y -= jumpforce
	#	speed = 0
		#print("located")

func _apply_gravity(delta):
	velocity.y += gravity * delta

func _apply_movement():
	velocity.x = 100 #speed
	velocity.y = move_and_slide(velocity, Vector2.UP).y

func _on_playerDetector_body_entered(body):
	if body.is_in_group("player"):
		#Signals.emit_signal("prey_caught", get_position().x)
		_prey_caught()
	else:
		return


func _on_VisibilityNotifier2D_screen_exited():
	_prey_offscreen()

func _prey_caught():
	
	visible = false
	
	Globals.prey_dead = 1
	Globals.flip = false
	#Signals.emit_signal("prey_caught", get_position().x)
	queue_free()

func _prey_offscreen():
	Globals.flip = false
	visible = false
	Globals.prey_dead = 1
