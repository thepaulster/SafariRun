extends Node

signal invulnerable(value)
signal player_location(value)

signal ground_destroyed
signal player_dead
signal prey_caught(value)
signal prey_dead
signal speed_boost
signal change_level
signal resume_on_thatlevel
signal on_resume_timeout
signal dashing_now
signal dash_ended

signal powerup_bar_show(value)
signal powerup_bar_hide

#pausing signals
signal pause
signal resume

#coins
signal coin_visible

