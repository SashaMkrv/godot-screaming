extends Node

# this is absolutely ridiculous. it sure works. absolutely wild. phenomanel. what happens if I give it the wrong node type???
export (NodePath) onready var playerCharacter = get_node(playerCharacter) as KinematicBody2D


func checkForYelling() -> bool:
	return Input.is_action_pressed("game_scream")


func getDirection() -> Vector2:
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	return Vector2(horizontal, vertical)


func passState(direction: Vector2, yelling: bool):
	if playerCharacter != null && playerCharacter.has_method("handleNewState"):
		playerCharacter.handleNewState(direction, yelling)


func _physics_process(delta):
	var yelling = checkForYelling()
	var direction = getDirection()
	passState(direction, yelling)
	pass
