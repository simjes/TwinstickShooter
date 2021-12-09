extends Area2D

func is_colliding():
	var bodies = get_overlapping_bodies()
	return bodies.size() > 0
	
func get_push_vector():
	var bodies = get_overlapping_bodies()
	var push_vector = Vector2.ZERO
	if is_colliding():
		var area = bodies[0]
		push_vector = area.global_position.direction_to(global_position)
		push_vector = push_vector.normalized()
	
	return push_vector
