extends KinematicBody2D


#distance run
var distance

const GRAVITY = 1500
const JUMP_SPEED = -600
var RUN_SPEED = 300
var SPEED


#dash movement
const DASH_SPEED = 500
const dash_length = 1

onready var dash_movement = get_node("Dash")
onready var playersprite = get_node("AnimatedSprite")


var velocity = Vector2.ZERO
var state = "running"
var set_invul = false

#hunger timer
onready var hunger_timer:Timer = get_node("hungerTimer") 

onready var animation_player:AnimationPlayer = get_node("AnimationPlayer")
onready var player_animation: AnimatedSprite = get_node("AnimatedSprite2")
onready var invul_timer = get_node("invulTimer")

func _ready():
	hunger_timer.start()
	Globals.playerSpeed = RUN_SPEED
	Globals.player_distance(position)
	print(Globals.player_distance)
	
	Signals.connect("player_stamina_empty", self, "_player_dead")
	Signals.connect("prey_caught", self, "_player_coordinates")
	Signals.connect("reduce_speed", self, "_hit_bush")
	pass

func _physics_process(delta):
	
	update_gravity(delta)
	update_state(delta)
	update_position(delta)
	
	$RichTextLabel.text = "FPS "+ String(Engine.get_frames_per_second())
	$RichTextLabel2.text = state
	
func update_state(delta):
	state = "running"
	SPEED = DASH_SPEED if dash_movement.is_dashing() else RUN_SPEED
	velocity.x = SPEED
	
	if !is_on_floor() and velocity.y >= 0:
		state = "fall"
	elif !is_on_floor() and velocity.y <= 0:
		state = "jumping"
	
	if state == "running":
		$AnimatedSprite3.visible = true
	else:
		$AnimatedSprite3.visible = false
	
func _input(event):	
	if event is InputEventScreenTouch and is_on_floor():
		#state = "jumping"
		velocity.y = JUMP_SPEED
		
	#testing the up button
	if Input.is_action_pressed("ui_down"):
		_player_dash()

func _process(delta):
	#distance = int(get_position().x/10)
	distance = int(get_position().x/50)
	Globals.distance_covered = distance

func update_gravity(delta):
	velocity.y += GRAVITY * delta

func update_position(delta):
	velocity.y = move_and_slide(velocity, Vector2.UP).y

func _invincibility():
	invul_timer.start()
	animation_player.play("invincibility")
	pass

func _on_invulTimer_timeout():
	set_invul = true
	if set_invul == true:
		animation_player.stop()
		player_animation.visible = true
	Signals.emit_signal("powerup_bar_hide")
	pass # Replace with function body.

func _player_dash():
	dash_movement.start_dash(playersprite, dash_length)
	if dash_movement.is_dashing():
		set_invul = true
		invul_timer.wait_time = dash_length + 2
		Signals.emit_signal("invulnerable", true)
		_invincibility()
		Signals.emit_signal("dashing_now")
	pass

func _on_hungerTimer_timeout():
	RUN_SPEED += 5
	Globals.playerSpeed = RUN_SPEED 
#	Signals.emit_signal("player_dead")

func _player_death():
	Signals.emit_signal("player_dead")

func _player_coordinates(value):
	
	#Globals.player_distance = position
	Globals.player_distance(position)
	Signals.emit_signal("test", position)
	pass

func _hit_bush(value):
	
	RUN_SPEED -= value
	
