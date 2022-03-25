extends KinematicBody2D

onready var stateTree : AnimationTree = $ComboTree
onready var moveStates : AnimationNodeStateMachinePlayback = stateTree["parameters/Walk/playback"]
onready var emoteStates : AnimationNodeStateMachinePlayback = stateTree["parameters/Emotion/playback"]


export (int) var speed = 50
var velocity := Vector2.ZERO


func _handleYellState(yelling: bool = false):
	if yelling:
		emoteStates.travel("Scream")
		return
	emoteStates.travel("NoScream")


func _handleMoveState():
	var horizontal = velocity.x
	# this is just one big giant ball of code duping. how nice.
	# a very sweet func. not dry at all.
	# also, checking a state machine for current state to figure out where to go?
	# I don't know which country's laws I'm breaking, but it's definitely one of them
	if velocity == Vector2.ZERO || speed == 0:
#		I think this might be working, which is absolutely wild
		if "Right" in moveStates.get_current_node():
			moveStates.travel("IdleRight")
		else:
			moveStates.travel("IdleLeft")
	elif velocity == Vector2.UP || velocity == Vector2.DOWN:
		if "Right" in moveStates.get_current_node():
			moveStates.travel("WalkRight")
		else:
			moveStates.travel("WalkLeft")
	elif horizontal > 0:
		moveStates.travel("WalkRight")
	elif horizontal < 0:
		moveStates.travel("WalkLeft")


func handleNewState(newVelocity: Vector2, yelling = false):
	velocity = newVelocity
	_handleMoveState()
	_handleYellState(yelling)
	move_and_slide(velocity * speed)
