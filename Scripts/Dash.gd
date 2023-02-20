extends Node2D

onready var dashTimer = get_node("dashTimer")
onready var ghostTimer = get_node("GhostTimer")

var ghost_scene = preload("res://Scenes/DashGhost.tscn")
var sprite

func start_dash(sprite, dur):
	self.sprite = sprite
	
	dashTimer.wait_time = dur
	dashTimer.start()
	
	ghostTimer.start()
	instance_ghost()

func instance_ghost():
	var ghost: Sprite = ghost_scene.instance()
	get_parent().get_parent().add_child(ghost)
	
	ghost.global_position = global_position
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h

func is_dashing():
	return !dashTimer.is_stopped()

func _on_dashTimer_timeout():
	end_dash()
	pass # Replace with function body.

func end_dash():
	ghostTimer.stop()
	Signals.emit_signal("dash_ended")


func _on_GhostTimer_timeout():
	instance_ghost()
	pass # Replace with function body.
