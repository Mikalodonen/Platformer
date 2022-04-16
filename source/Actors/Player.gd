extends Actor

export var stomp_impulse: = 1000.0

func _on_Enemy_stomp_area_entered(area):
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_Enemy_stomp_body_entered(body):
	die()
	

#func _physics_process(delta: float) -> void:
#
##is_jump_interrupted gør at man kun kan hoppe højest hvis man holder knappen inde
#	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
#	var direction = get_direction()
#	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
#	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)


#func get_direction() -> Vector2:
#	return Vector2(
#		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
#		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
#	)
#
#func calculate_move_velocity(
#		linear_velocity: Vector2,
#		direction: Vector2,
#		speed: Vector2,
#		is_jump_interrupted: bool
#	) -> Vector2:
#	var out: = linear_velocity
#	out.x = speed.x * direction.x
##delta bruges til at hvis spillet ligepludselig kører langsommere så vil playeren stadig bevæg sig med samme hastighed
#	out.y += gravity * get_physics_process_delta_time()
#	if direction.y == -1.0:
#		out.y = speed.y * direction.y
#	if is_jump_interrupted:
#			out.y = 0.0
#	return out


func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

func die() -> void:
	PlayerData.death +=1
	queue_free()
#
##alt her under bruges til animationerne
#func _process(delta):
#	if Input.is_action_pressed("move_right"):
#		$AnimatedSprite.play("walk")
#		$AnimatedSprite.flip_h = false
#
#	elif Input.is_action_pressed("move_left"):
#		$AnimatedSprite.play("walk")
#		$AnimatedSprite.flip_h = true
#
#	else:
#		if is_on_floor() == true:
#			$AnimatedSprite.play("idle")
#
#	if is_on_floor() == false:
#		$AnimatedSprite.play("jump")
#	if _velocity.y > 0:
#		$AnimatedSprite.play("fall")

#tidligere fejlede forsøg
#	if _velocity.y < 0:
#		$AnimatedSprite.play("jump")
#	else:
#		$AnimatedSprite.play("fall")
#
#	if is_on_floor() == true:
#			$AnimatedSprite.play("idle")

#	if Input.is_action_just_pressed("jump"):
#		$AnimatedSprite.play("jump")

