extends Node2D

onready var timer = $Timer

export(float) var waitTime = 3
export(int) var numberOfSpawns = 1
export (Array, PackedScene) var Enemies = []
var spawnPoints = []

func _ready():
	spawn_enemy()
	timer.start(waitTime)
	
func spawn_enemy():
	var Enemy = Enemies[randi() % Enemies.size()]
	
	for i in numberOfSpawns:
		var enemy = Enemy.instance()
		get_tree().current_scene.call_deferred("add_child", enemy)
		
		if spawnPoints.size() > 0:
			var spawnIndex = randi() % spawnPoints.size()
			enemy.position = spawnPoints[spawnIndex]
		else:
			enemy.position = global_position

func _on_Timer_timeout():
	spawn_enemy()
