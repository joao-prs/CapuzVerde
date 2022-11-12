class_name Enemy
extends KinematicBody2D

export var speed := 16
export var velocity := Vector2.ZERO
export var walk_direction := 1
export var jump_impulse := 200

var gravity = 450

onready var _pivot := $Sprite
onready var _start_scale: Vector2 = _pivot.scale

func get_direction():
	if walk_direction != 0:
		_pivot.scale.x = sign(walk_direction) * _start_scale.x
	return walk_direction
