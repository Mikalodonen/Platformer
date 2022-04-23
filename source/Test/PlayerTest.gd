extends KinematicBody2D

class_name Player


export var speed = 50
export var jump_power = 800
export var stopping_friction = 0.6
export var running_friction = 0.9
export var gravity = 30

var vel = Vector2()

var jumps_left = 2
var dash_direction = Vector2(1,0)
var can_dash = false
var dashing = PlayerData.dashing


func _physics_process(delta):
	run(delta)
	jump()
	dash()
	friction()
	gravity()
	handle_textures()
	vel = move_and_slide(vel, Vector2.UP)

func _on_Enemy_stomp_body_entered(body):
	if not dashing:
		die()

func run(delta):
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		$AnimatedSprite.flip_h = false
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
		$AnimatedSprite.flip_h = true


func jump():
	# I can jump when I'm on floor or next to the wall
	if is_on_floor():
		jumps_left = 1 # Recharge double-jump. 
	
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		if vel.y > 0: vel.y = 0 # if I'm falling - ignore fall velocity
		vel.y -= jump_power
		jumps_left -= 1
		# Jump away from the wall
		if not is_on_floor():
			vel.x += jump_power
		if not is_on_floor():
			vel.x -= jump_power
	
	# If I'm still going up and have released the jump button - cut off the jump and start falling down
	if Input.is_action_just_released("jump") and vel.y < 0:
		vel.y = 0


func friction():
	# When I hold the key
	var running = Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
	if not running and is_on_floor():
		vel.x *= stopping_friction
	else:
		vel.x *= running_friction


func gravity():
	if not dashing:
		vel.y += gravity
	if vel.y > 800: 
		vel.y = 800 # clamp falling speed
#	if next_to_wall() and vel.y > 100: 
#		vel.y = 100 # wall slide


func dash():
	if is_on_floor():
		can_dash = true # recharges when player touches the floor

	if Input.is_action_pressed("move_right"):
		dash_direction = Vector2(1,0)
	if Input.is_action_pressed("move_left"):
		dash_direction = Vector2(-1,0)

	if Input.is_action_just_pressed("bash") and can_dash:
		vel = dash_direction.normalized() * 2000
		can_dash = false
		dashing = true # turn off gravity while dashing
		yield(get_tree().create_timer(0.2), "timeout")
		dashing = false

func next_to_wall():
	return next_to_left_wall() or next_to_right_wall()
	
func next_to_left_wall():
	return $LeftWallRaycast1.is_colliding() or $LeftWallRaycast2.is_colliding()

func next_to_right_wall():
	return $RightWallRaycast1.is_colliding() or $RightWallRaycast2.is_colliding()


#func take_damage():
#	get_tree().change_scene("res://Levels/Level02.tscn")
func die() -> void:
	PlayerData.death +=1
	queue_free()

func handle_textures():
	if not is_on_floor() and Input.is_action_pressed("jump"):
		$AnimatedSprite.play("jump")

	if not is_on_floor() and vel.y > 0:
		$AnimatedSprite.play("fall")

	if not is_on_floor() and next_to_left_wall():
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	if not is_on_floor() and next_to_right_wall():
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	var running = Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") and is_on_floor()
	if running and is_on_floor():
		$AnimatedSprite.play("walk")

	if not running and is_on_floor():
		$AnimatedSprite.play("idle")
	
