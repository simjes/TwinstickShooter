extends CharacterBody2D

const Bullet = preload("res://Player/Bullet.tscn")

@onready var GunNode = $GunNode
@onready var GunPosition = $GunNode/GunPosition2D
@onready var GunTimer = $GunNode/Timer
@onready var hurtBox = $Hurtbox
@onready var blinkAnimationPlayer = $BlinkAnimationPlayer
@onready var canvasLayer = get_node("/root/World/CanvasLayer")

var GameOverScene = preload("res://UI/GameOverPopup.tscn")

@export var ACCELERATION = 500
@export var MAX_SPEED = 200
@export var FRICTION = 500
@export var FIRE_DELAY = 0.1

var stats = PlayerStats

signal player_hit

func _ready():
	stats.connect("no_health", Callable(self, "player_death"))

func _physics_process(delta):
	process_move(delta)
	process_shoot(delta)

func process_move(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		rotation = lerp_angle(rotation, input_vector.normalized().angle(), 0.1)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity

func process_shoot(delta):
	var input_vector = Input.get_vector("shoot_left", "shoot_right", "shoot_up", "shoot_down")
	if input_vector != Vector2.ZERO and GunTimer.is_stopped():
		# Pre Node2D - setting position based on player position + input vector
#		GunPosition.global_position = global_position + input_vector.normalized() * GUN_DISTANCE
		
		GunTimer.start(FIRE_DELAY)
		
		# Rotates the pivot node
		GunNode.look_at(global_position + input_vector.normalized())
		
		var bullet = Bullet.instantiate()
		# in degrees: rotation_degrees = fmod(rotation_degrees, 360)
		var radians = fmod(input_vector.normalized().angle(), TAU)
		bullet.position = GunPosition.global_position
		bullet.velocity = bullet.velocity.move_toward(input_vector * bullet.speed, ACCELERATION * delta)
		bullet.rotate(radians)
		
		get_tree().current_scene.add_child(bullet)
		
	# Pre Node2D
	#	else:
	#		GunPosition.global_position = global_position

func player_death():
	queue_free()
	get_tree().paused = true
	var game_over = GameOverScene.instantiate()
	canvasLayer.add_child(game_over)
	
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	
	hurtBox.start_invincibility(0.5)
#	hurtBox.create_hit_effect()
	
	emit_signal("player_hit")

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")

func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")
