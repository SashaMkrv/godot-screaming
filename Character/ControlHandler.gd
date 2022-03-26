extends "res://Character/CharacterController.gd"


func checkForYelling() -> bool:
	return Input.is_action_pressed("game_scream")


func getDirection() -> Vector2:
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
#	vertical = 0
	# we're going to ignore this axis for aesthetic purposes for now.
	return Vector2(horizontal, vertical)

func screamCollision(isYelling = false):
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", not isYelling)
#	$StaticBody2D.visible = isYelling

#func _physics_process(delta):
#	var yelling = checkForYelling()
#	var direction = getDirection()
#	screamCollision(yelling)
#	.handleNewState(direction, yelling)
