extends CharacterBody2D

@onready var player = get_node("/root/World/Player")
@onready var score = get_node("/root/World/CanvasLayer/ScoreUI")
@onready var stats = $Stats
@onready var softCollision = $SoftCollision
@onready var bulletDodge = $BulletDodge

@export var ACCELERATION = 500
@export var MAX_SPEED = 150

func _ready():
	if !is_instance_valid(player):
		return
	player.connect("player_hit", Callable(self, "queue_free"))

func _physics_process(delta):
	if !is_instance_valid(player):
		return
	
	var player_position = player.position
	var direction = global_position.direction_to(player_position)
	
	if (bulletDodge.is_colliding()):
		velocity += bulletDodge.get_push_vector() * delta * 1000
	else: 
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

	look_at(player_position)
	
	if (softCollision.is_colliding()):
		velocity += softCollision.get_push_vector() * delta * 400
	
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity

func _on_Stats_no_health():
	queue_free()

func _on_Hurtbox_body_entered(_body):
	stats.health -= 1
	score.emit_signal("add_score", stats.points)
