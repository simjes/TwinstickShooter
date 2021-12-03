extends KinematicBody2D

const Bullet = preload("res://Player/Bullet.tscn")

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
	var input_vector = Input.get_vector("shoot_left", "shoot_right", "shoot_up", "shoot_down")
	if input_vector != Vector2.ZERO:

		var bullet_instance = Bullet.instance()
		owner.add_child(bullet_instance)

		var bullet_transform = transform
		bullet_transform.x = transform.x + input_vector.normalized()
		bullet_instance.transform = bullet_transform
		
