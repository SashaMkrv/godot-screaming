extends KinematicBody2D

onready var stateTree : AnimationTree = $ComboTree
onready var moveStates : AnimationNodeStateMachinePlayback = stateTree["parameters/Walk/playback"]
onready var emoteStates : AnimationNodeStateMachinePlayback = stateTree["parameters/Emotion/playback"]


export (int) var speed = 50
var velocity := Vector2.ZERO


func handleYellState(yelling: bool = false):
	if yelling:
		emoteStates.travel("Scream")
		return
	emoteStates.travel("NoScream")


func handleMoveState():
	var horizontal = velocity.x
	if velocity == Vector2.ZERO:
#		I think this might be working, which is absolutely wild
		if "Right" in moveStates.get_current_node():
			moveStates.travel("IdleRight")
		else:
			moveStates.travel("IdleLeft")
	elif horizontal > 0:
		moveStates.travel("WalkRight")
	elif horizontal < 0:
		moveStates.travel("WalkLeft")
		


func handleNewState(newVelocity: Vector2, yelling = true):
	velocity = newVelocity
	handleMoveState()
	handleYellState(yelling)
	move_and_slide(velocity * speed)
