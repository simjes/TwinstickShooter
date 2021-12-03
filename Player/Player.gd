extends KinematicBody2D

const Bullet = preload("res://Player/Bullet.tscn")

onready var GunNode = $GunNode
onready var GunPosition = $GunNode/GunPosition2D
onready var GunTimer = $GunNode/Timer

var can_shoot = true

export var ACCELERATION = 500
export var MAX_SPEED = 200
export var FRICTION = 500

var velocity = Vector2.ZERO

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
	
	velocity = move_and_slide(velocity)

func process_shoot(delta):
	if !can_shoot:
		return
	
	var input_vector = Input.get_vector("shoot_left", "shoot_right", "shoot_up", "shoot_down")
	if input_vector != Vector2.ZERO:
		# Pre Node2D - setting position based on player position + input vector
#		GunPosition.global_position = global_position + input_vector.normalized() * GUN_DISTANCE
		
		# TODO: make reusable for upgraded weapons
		can_shoot = false
		GunTimer.start(.1)
		
		GunNode.look_at(global_position + input_vector.normalized())
		
		var bullet = Bullet.instance()
		bullet.position = GunPosition.global_position
		bullet.velocity = bullet.velocity.move_toward(input_vector * bullet.speed, ACCELERATION * delta)
		
		# got a bug here - when player changes direction GunNode.rotation changes
		print(GunNode.rotation)
		bullet.rotate(GunNode.rotation)
		
		get_tree().current_scene.add_child(bullet)
		
	# Pre Node2D
	#	else:
	#		GunPosition.global_position = global_position

func _on_Timer_timeout():
	can_shoot = true
