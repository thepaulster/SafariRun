extends KinematicBody2D

var powerupready = false
var swipeStartPosition: Vector2
const swipeThreshold: float = 100.0 # Minimum distance to register as a swipe
const swipeTimeThreshold: float = 0.3 # Maximum time allowed to register a swipe

var swipeEndPosition: Vector2

var distance: int

const GRAVITY: float = 2000.0
const JUMP_SPEED: float = -600.0
const RUN_SPEED: float = 300.0
var SPEED: float = RUN_SPEED

const DASH_SPEED: float = 500.0
const dashLength: float = 1.0

onready var dashMovement: Node2D = $Dash
onready var playerSprite: Sprite = $AnimatedSprite

var velocity: Vector2 = Vector2.ZERO
var state: String = "running"
var setInvulnerable: bool = false

onready var hungerTimer: Timer = $hungerTimer
onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var player_animation: AnimatedSprite = $AnimatedSprite2
onready var invulTimer: Timer = $invulTimer

func _ready():
	hungerTimer.start()
	Globals.playerSpeed = RUN_SPEED
	Globals.player_distance(position)
	powerupready = Globals.powerupready
	
	Signals.connect("player_stamina_empty", self, "_player_death")
	Signals.connect("prey_caught", self, "_player_coordinates")
	Signals.connect("reduce_speed", self, "_hit_bush")
	Signals.connect("speed_boost", self, "_player_dash")

func _physics_process(delta: float) -> void:
	update_gravity(delta)
	update_state(delta)
	update_position(delta)

func update_state(delta: float) -> void:
	state = "running"
	SPEED = DASH_SPEED if dashMovement.is_dashing() else RUN_SPEED
	velocity.x = SPEED
	if !is_on_floor() and velocity.y >= 0:
		state = "fall"
	elif !is_on_floor() and velocity.y <= 0:
		state = "jumping"
	
	if dashMovement.is_dashing():
		state = "dashing"

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and is_on_floor():
		velocity.y = JUMP_SPEED
	
	swipe_input(event)

func _process(delta: float) -> void:
	distance = int(get_position().x / 50)
	Globals.distance_covered = distance

func update_gravity(delta: float) -> void:
	velocity.y += GRAVITY * delta

func update_position(delta: float) -> void:
	velocity.y = move_and_slide(velocity, Vector2.UP).y

func _invincibility() -> void:
	invulTimer.start()
	animationPlayer.play("invincibility")

func _on_invulTimer_timeout() -> void:
	setInvulnerable = true
	if setInvulnerable:
		animationPlayer.stop()
		player_animation.visible = true
	Signals.emit_signal("powerup_bar_hide")
	Signals.emit_signal("powerup_used")

func _player_dash() -> void:
	dashMovement.start_dash(playerSprite, dashLength)
	if dashMovement.is_dashing():
		setInvulnerable = true
		invulTimer.wait_time = dashLength + 2
		Signals.emit_signal("invulnerable", true)
		_invincibility()
		Signals.emit_signal("dashing_now")
		Signals.emit_signal("powerup_used")
	

func _on_hungerTimer_timeout() -> void:
	Globals.playerSpeed += 5

func _player_death() -> void:
	Signals.emit_signal("player_dead")

func _player_coordinates(value) -> void:
	Globals.player_distance(position)
	Signals.emit_signal("test", position)

func _hit_bush(value: float) -> void:
	Globals.playerSpeed -= value

func swipe_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		var touch: InputEventScreenTouch = event
		if touch.pressed:
			swipeStartPosition = touch.position
		else:
			swipeEndPosition = touch.position
			var swipeVector: Vector2 = swipeEndPosition - swipeStartPosition
			var swipeDistance: float = swipeVector.length()

			if swipeDistance > swipeThreshold:
				var swipeDirection: Vector2 = swipeVector.normalized()

				if swipeDirection.x > 0 and Globals.powerupready == true:
					_player_dash()
					Globals.powerupready = false
				
				elif swipeDirection.x < 0:
					print("Right to left swipe detected.")
