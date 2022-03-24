extends KinematicBody2D

onready var animationTree : AnimationTree = $AnimationTree
onready var stateMachine : AnimationNodeStateMachinePlayback = animationTree["parameters/playback"]

var speed := 50
var velocity := Vector2.ZERO

func _input(event: InputEvent):
	var isEmoting = false
	var nextState = "Idle"
	if event.is_action_pressed("game_big_scream"):
		isEmoting = true
		nextState = "Big Scream"
		stateMachine.travel("Big Scream")
	elif event.is_action_pressed("game_scream"):
		isEmoting = true
		nextState = "Scream"
		stateMachine.travel("Scream")
	elif event.is_action_pressed("game_big_cry"):
		isEmoting = true
		nextState = "Big Cry"
		stateMachine.travel("Big Cry")
	elif event.is_action_pressed("game_cry"):
		isEmoting = true
		nextState = "Cry"
		stateMachine.travel("Cry")
	# need to pop this out into a function to limit all those bool sets. gross.
	if isEmoting:
		return
	
	
	velocity = Vector2.ZERO
	var horizontal = event.get_action_strength("ui_right") - event.get_action_strength("ui_left")
	
	var vertical = event.get_action_strength("ui_down") - event.get_action_strength("ui_up")
	vertical = 0
	# we're going to ignore this axis for aesthetic purposes for now.
	
	velocity = Vector2.ZERO + Vector2(horizontal, vertical)
	
	if velocity == Vector2.ZERO:
		stateMachine.travel("Idle")
	elif horizontal > 0:
		stateMachine.travel("WalkRight")
	elif horizontal < 0:
		stateMachine.travel("WalkLeft")


func _physics_process(_delta):
	move_and_slide(velocity * speed)
