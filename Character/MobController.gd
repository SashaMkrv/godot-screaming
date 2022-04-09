extends Node


export (NodePath) onready var mobParent = get_node(mobParent) as Node
export (int, 1, 500) var mobCount

onready var mobScene = preload("res://Character/CrossWalkerCharacter.tscn")

onready var screenWidth : int = ProjectSettings.get_setting("display/window/size/width")

var mobNodes := []


func _ready():
	spawnMobs()
	initialMoveMobs()
	pass


func spawnMobs() -> void:
	for i in range(0, mobCount):
		var mob = mobScene.instance()
		slapOnAColor(mob)
		slapOnAColor(mob)
		mobParent.add_child(mob)
		mobNodes.append({"mob": mob, "right": bool(i % 2)})


func slapOnAColor(mob: Node) -> void:
	var green = rand_range(0.5, 1)
	var red = rand_range(0, 0.5)
	var blue = rand_range(0, 0.5)
	mob.modulate = Color(red, green, blue)


func slapOnASpeed(mob: Node) -> void:
	var minSpeed := 40
	mob.speed = randi() % 40 + minSpeed


func initialMoveMobs() -> void:
	for mobDic in mobNodes:
		moveMobToStart(mobDic["mob"], -40, screenWidth + 40)
	pass


#func moveMobs() -> void:
#	for mobDic in mobNodes:
#		print(mobDic["right"])
#		if mobDic["right"]:
#			moveMobToStartLeft(mobDic["mob"])
#		pass


func moveMobToStartLeft(mob):
	moveMobToStart(mob, -100, -16)
func moveMobToStartRight(mob):
	moveMobToStart(mob, screenWidth + 16, screenWidth + 100)

func moveMobToStart(mob, xmin, xmax):
	var ymin = 90
	var spawnXRange = xmax - xmin
	var spawnYRange = 100
	
	var newX = randi() % spawnXRange + xmin
	var newY = randi() % spawnYRange + ymin
	mob.position = Vector2(newX, newY)


func _physics_process(delta):
	for mobDic in mobNodes:
		if mobDic["right"]:
			if mobDic["mob"].position.x < screenWidth + 40:
				moveRight(mobDic["mob"])
			else:
				moveMobToStartLeft(mobDic["mob"])
		else:
			if mobDic["mob"].position.x > -40:
				moveLeft(mobDic["mob"])
			else:
				moveMobToStartRight(mobDic["mob"])


func moveRight(mob: Node):
	move(mob, Vector2.RIGHT)


func moveLeft(mob: Node):
	move(mob, Vector2.LEFT)


func move(mob: Node, direction: Vector2):
	if mob.has_method("handleNewState"):
		mob.handleNewState(direction)
	else:
		print("mob can't move because I don't know what to call on it :(")
