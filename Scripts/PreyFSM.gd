extends "res://Scripts/StateMachine.gd"


func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("invulnerable")
	add_state("dash")
	call_deferred("set_state", states.idle)
	pass

func _state_logic(delta):
	parent._apply_jump()
	parent._apply_gravity(delta)
	parent._apply_movement()

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor(): 
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0:
				return states.run
		states.run:
			if !parent.is_on_floor(): 
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
				
	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.run:
			parent.animated_sprite.play("run")
		states.jump:
			parent.animated_sprite.play("jump")
		states.fall:
			parent.animated_sprite.play("fall")
			pass

func _exit_state(old_state, new_state):
	pass
