extends Node2D

export(float) var waitTime = 3
export(String, FILE) var EnemyPath = null
var spawnPoints = []

func _on_Timer_timeout():
	var Enemy = load(EnemyPath)
	var enemy = Enemy.instance()
	get_tree().current_scene.add_child(enemy)
	
	if spawnPoints.size() > 0:
		var spawnIndex = randi() % spawnPoints.size()
		enemy.position = spawnPoints[spawnIndex]
	else:
		enemy.position = global_position
