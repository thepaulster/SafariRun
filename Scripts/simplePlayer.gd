extends KinematicBody2D


const GRAVITY = 1000
const JUMP_FORCE = -500

var velocity = Vector2.ZERO
var speed = 200

func _physics_process(delta):
	
	velocity.y += GRAVITY * delta
	velocity.x = speed
	
	$RichTextLabel.text = "FPS "+ String(Engine.get_frames_per_second())
	
	move_and_slide(velocity)
	
	
	if Input.is_action_just_pressed("ui_up"):
		
		velocity.y = JUMP_FORCE
