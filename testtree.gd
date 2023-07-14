extends Control

var swipeStartPosition
var swipeThreshold = 100 # Minimum distance to register as a swipe
var swipeTimeThreshold = 0.3 # Maximum time allowed to register a swipe

var swipeEndPosition

func _input(event):
	if event is InputEventScreenTouch:
		var touch = event as InputEventScreenTouch
		if touch.pressed:
			swipeStartPosition = touch.position
		#elif touch.is_action_released("touch"):
		else:
			swipeEndPosition = touch.position
			var swipeVector = swipeEndPosition - swipeStartPosition
			var swipeDistance = swipeVector.length()
			#var swipeTime = touch.get_time()

			if swipeDistance > swipeThreshold: #and swipeTime < swipeTimeThreshold:
				var swipeDirection = swipeVector.normalized()

				if swipeDirection.x > 0:
					# Left to right swipe detected
					print("Left to right swipe detected.")
				elif swipeDirection.x < 0:
					# Right to left swipe detected
					print("Right to left swipe detected.")
