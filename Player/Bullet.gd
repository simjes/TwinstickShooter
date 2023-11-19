extends CharacterBody2D

var speed = 300

func _physics_process(delta):
# warning-ignore:return_value_discarded
	move_and_collide(velocity.normalized() * delta * speed)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
