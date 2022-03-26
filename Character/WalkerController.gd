extends "res://Character/CharacterController.gd"

export (bool) var goingRight


func getDirection() -> Vector2:
	if goingRight:
		return Vector2.RIGHT
	return Vector2.LEFT


func _physics_process(delta):
	var direction = getDirection()
	.handleNewState(direction)
