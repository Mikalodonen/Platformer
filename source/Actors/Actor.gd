extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)

#hvor hurtigt man falder
export var gravity: = 4000.0

#hvor meget/hurtigt playeren bevæger sig til højre pr pixel
#var _velocity: = Vector2(300, 0)
var _velocity: = Vector2.ZERO

