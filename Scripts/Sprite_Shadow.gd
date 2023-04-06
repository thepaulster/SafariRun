extends Sprite

func _process(delta):
	# Get the character's position
	var char_pos = get_parent().get_node("AnimatedSprite").position
	
	# Update the shadow's position to be directly below the character
	position = Vector2(char_pos.x, 0) + Vector2(0, 32)
