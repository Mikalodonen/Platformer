extends Area2D

func _ready():
	pass


func _on_Trampoline_body_entered(body):
	if body is Player:
		die()


func die() -> void:
	queue_free()
