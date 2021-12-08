extends Control

onready var player = get_node("/root/World/Player")
onready var label = $Label
var score = 0
var kill_combo = 0
var score_multiplier = 1

signal add_score(points)

func _ready():
	label.text = String(score)
	player.connect("player_hit", self, "reset_multiplier")
	
func reset_multiplier():
	kill_combo = 0
	score_multiplier = 1

func set_score_multiplier():
	if kill_combo >= 1000:
		score_multiplier = 10
		return
	
	if kill_combo >= 50:
		score_multiplier = 3
		return
	
	if kill_combo >= 2:
		score_multiplier = 2
		return

func _on_ScoreUI_add_score(points):
	score += points * score_multiplier
	label.text = String(score)
	kill_combo += 1
	set_score_multiplier()
