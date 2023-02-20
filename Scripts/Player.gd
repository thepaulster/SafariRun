extends KinematicBody2D

signal is_Done

export var normal_speed = 220
export var jumpforce = 1600
export var gravity = 4000
var speed

var grav_variable
var dashgravity = 0

var dash_speed = 420
var velocity = Vector2()

var run = "hyenarun"
var jump = "hyenajump"
var fall = "hyenafall"

var invul = true #variable for invulnerabilty
var coin_magnet = false #variable for coin_attracted

var dash = false
var distance = 0
var only_once_distance = true

onready var anim_player = get_node("AnimationPlayer")
onready var animated_sprite = get_node("AnimatedSprite")
onready var invul_timer = get_node("invulnerabilityTimer")

#adjust invul wait time
var invulwait  = 3

const dashSpeed = 800
# adjust dashlength with global dash_length
const dashLength = 1 #0.1
onready var dash_movement = get_node("Dash")


var caught = true
var prey_once = true

#sound values
#onready var runsound = get_node("footstepSound")

onready var dust_particles = get_node("CPUParticles2D")
onready var sprite = get_node("Sprite")

func _ready():
	get_tree().paused = false
	invul = false
	sprite.visible = false
	sprite.texture = load("res://Assets/Player Assets/Hyena/frame0018.png") 
	Globals.player_distance = Vector2(0, 0)
	#coin_magnet = true
	Signals.connect("player_dead", self, "_playerdead")
	Signals.connect("prey_caught", self, "prey_caught")
	Globals.connect("prey_done", self, "prey_caught")
	Signals.connect("invulnerable", self, "_invul_func")
	Signals.connect("speed_boost", self, "_player_dash")

func invulnurable_now():
	invul_timer.wait_time = invulwait #invul_wait_time
	Signals.emit_signal("powerup_bar_show")
	Globals.powerUp_bar_value = invulwait
	Globals.bar_value(invulwait)
	invul_timer.start()
	if invul == true:
		anim_player.play("invulnerability")

func _handle_move_input():
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and !dash_movement.is_dashing():
		velocity.y -= jumpforce
		#$PreyTimer.start()
	if Input.is_action_pressed("ui_down"):
	#	dash = true
	#	dash_movement.start_dash(dashLength)
	#if Input.is_action_just_released("ui_down"):
	#	dash = false
		_player_dash()
	pass

func prey_caught(value): 
	caught = value
	Globals.player_distance = get_position()

func _process(delta):
	#distance = int(get_position().x/10)
	$RichTextLabel.text = "FPS "+ String(Engine.get_frames_per_second())
	
	Globals.distance_covered = distance
#	distance += Globals.distance_covered
	
	#if distance == 100 and only_once_distance == true:
	#	Signals.emit_signal("change_level")
	#	only_once_distance = false
	pass

func _apply_gravity(delta):
	#grav_variable = dashgravity if dash_movement.is_dashing() else gravity
	#if dash_movement.is_dashing():
	#	grav_variable = dashgravity
	#else:
	grav_variable = gravity
	velocity.y += grav_variable * delta

func _apply_movement():
	
	speed = dashSpeed if dash_movement.is_dashing() else normal_speed
	velocity.x = speed
	velocity.y = move_and_slide(velocity, Vector2.UP).y

#func _player_dash():
	#if dash == true:
	#	normal_speed = dash_speed * 2
	#if dash == false:
	#	normal_speed = 420
	#speed = dashSpeed if dash_movement.is_dashing() else normal_speed
	pass

func coin_magnet():
	if coin_magnet == true:
		Signals.emit_signal("player_location", Vector2(position.x, position.y))
	else:
		pass
	pass

func _on_invulnerabilityTimer_timeout():
	invul = false
	Signals.emit_signal("invulnerable", invul)
	if invul == false:
		anim_player.stop()
		$AnimatedSprite.visible = true
		Signals.emit_signal("powerup_bar_hide")
	pass # Replace with function body.

func _playerdead(): #bring a popup for death screen
	Signals.emit_signal("powerup_bar_hide")
	normal_speed = 0
	pass

func _on_PreyTimer_timeout():
	var pos = 0 
	pos = get_global_position().x
	
	Signals.emit_signal("player_location", get_global_position().x)
	Globals.player_distance = pos
	
	#print(pos)
		
	pass # Replace with function body.

func _invul_func(value):
	invul = value
	invulnurable_now()
	pass

func _player_dash():
	dash_movement.start_dash(sprite, dashLength)
	if dash_movement.is_dashing():
		invul = true
		invul_timer.wait_time = dashLength + 2
		Signals.emit_signal("invulnerable", true)
		invulnurable_now()
		Signals.emit_signal("dashing_now")
	pass


func _on_prey_body_entered(body):
	#Globals.player_distance = get_position()
	#Globals.prey_dead = 1
	pass # Replace with function body.
