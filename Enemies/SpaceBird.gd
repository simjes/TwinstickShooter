extends KinematicBody2D

onready var player = get_node("/root/World/Player")
onready var score = get_node("/root/World/CanvasLayer/ScoreUI")
onready var stats = $Stats
onready var softCollision = $SoftCollision

export var ACCELERATION = 500
export var MAX_SPEED = 200

var velocity = Vector2.ZERO

func _ready():
	if !is_instance_valid(player):
		return
	player.connect("player_hit", self, "queue_free")

func _physics_process(delta):
	if !is_instance_valid(player):
		return
	
	var player_position = player.position
	var direction = global_position.direction_to(player_position)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

	look_at(player_position)
	
	if (softCollision.is_colliding()):
		velocity += softCollision.get_push_vector() * delta * 400
	
	# TODO: dodge bullets
	
	velocity = move_and_slide(velocity)

func _on_Stats_no_health():
	queue_free()

func _on_Hurtbox_body_entered(_body):
	stats.health -= 1
	score.emit_signal("add_score", stats.points)
