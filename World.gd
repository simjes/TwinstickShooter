extends Node2D

func _on_BulletDespawn_body_entered(body):
	body.queue_free()
