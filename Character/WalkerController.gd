extends Node2D

onready var character := $Character

export (int) var speed
export (bool) var goingRight


func _ready():
	character.speed = speed



func getDirection() -> Vector2:
	if goingRight:
		return Vector2.RIGHT
	return Vector2.LEFT


func _physics_process(delta):
	var direction = getDirection()
	character.handleNewState(direction)
