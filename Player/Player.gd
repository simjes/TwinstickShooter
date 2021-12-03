extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 200
export var FRICTION = 500

var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	print(input_vector)
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		var target_vector = input_vector + position
		rotation = lerp_angle(rotation, (target_vector - position).normalized().angle(), 0.1)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

