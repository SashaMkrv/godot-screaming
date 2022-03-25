extends Node2D

onready var character := $Character
export (int) var speed = 70


func _ready():
	character.speed = speed


func checkForYelling() -> bool:
	return Input.is_action_pressed("game_scream")


func getDirection() -> Vector2:
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	vertical = 0
	# we're going to ignore this axis for aesthetic purposes for now.
	return Vector2(horizontal, vertical)



func _physics_process(delta):
	var yelling = checkForYelling()
	var direction = getDirection()
	character.handleNewState(direction, yelling)
