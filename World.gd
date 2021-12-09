extends Node2D

onready var OrganicEnemySpawner = $OrganicEnemySpawner
onready var SpaceBirdEnemySpawner = $SpaceBirdEnemySpawner
onready var TopLeftLimit = $Camera2D/Limits/TopLeft
onready var BottomRightLimit = $Camera2D/Limits/BottomRight
onready var PausePopup = $PausePopup

func _ready():
	var topLeft = TopLeftLimit.position
	var bottomRight = BottomRightLimit.position
	var bottomLeft = Vector2(topLeft.x, bottomRight.y)
	var topRight = Vector2(bottomRight.x, topLeft.y)
	
	OrganicEnemySpawner.spawnPoints = [topLeft, bottomRight, bottomLeft, topRight]
	SpaceBirdEnemySpawner.spawnPoints = [topLeft, bottomRight, bottomLeft, topRight]
