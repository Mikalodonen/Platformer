extends "res://source/Actors/Actor.gd"

export var score: = 100

class_name Wall

func _ready() -> void:
	_velocity.x = -speed.x
	set_physics_process(false)


func _on_Stomp_body_entered(body):
	if body is Player:
		die()


func die() -> void:
	queue_free()
	PlayerData.score += score

