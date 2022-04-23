extends "res://source/Actors/Actor.gd"

export var score: = 100

func _ready() -> void:
	_velocity.x = -speed.x
	set_physics_process(false)

func _on_Stomp_body_entered(body):
	if body.global_position.y > get_node("Stomp").global_position.y:
		return
	die()
#	if body.global_position.y > get_node("Stomp").global_position.y:
#		return
#	get_node("CollisionShape2D").disabled = true
#	queue_free()

#func _on_bash_body_entered(body):
#	if PlayerData.dashing == true:
#		return
##		get_node("bash/CollisionBash").disabled = false
#		die()
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die() -> void:
	queue_free()
	PlayerData.score += score

