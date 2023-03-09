extends KinematicBody2D


const GRAVITY = 1500
const JUMP_SPEED = -600
const RUN_SPEED = 300

var velocity = Vector2.ZERO
var state = "running"
var animation_player:AnimationPlayer
#onready var groundCast: RayCast2D = get_node("GroundCast")

func _ready():
	animation_player

func _physics_process(delta):
	
	update_gravity(delta)
	update_state(delta)
	update_position(delta)
	
	$RichTextLabel.text = "FPS "+ String(Engine.get_frames_per_second())
	$RichTextLabel2.text = state
	
func update_state(delta):
	state = "running"
	velocity.x = RUN_SPEED
	
	if !is_on_floor() and velocity.y >= 0:
		state = "fall"
	elif !is_on_floor() and velocity.y <= 0:
		state = "jumping"

func _input(event):	
	if event is InputEventScreenTouch and is_on_floor():
		#state = "jumping"
		velocity.y = JUMP_SPEED
	

func update_gravity(delta):
	velocity.y += GRAVITY * delta

func update_position(delta):
	velocity.y = move_and_slide(velocity, Vector2.UP).y
