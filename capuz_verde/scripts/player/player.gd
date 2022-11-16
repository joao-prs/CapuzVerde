class_name Player
extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var health = 3

export var speed = 60
export var deceleration = 10
export var aceleration = 10

export var jump_strength = 200
export var gravity = 450

export var can_input = true
var velocity := Vector2.ZERO

onready var _pivot := $Sprite
onready var _start_scale: Vector2 = _pivot.scale
onready var changer = get_parent().get_node("transition_in")

func get_input_direction() -> float:
	var direction = (
		Input.get_action_strength("ui_right") 
		- Input.get_action_strength("ui_left"))
	if not is_zero_approx(velocity.x):
		_pivot.scale.x = sign(velocity.x) * _start_scale.x
	
	return direction
