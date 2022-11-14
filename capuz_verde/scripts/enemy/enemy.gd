class_name Enemy
extends KinematicBody2D

export var speed := 16
var velocity := Vector2.ZERO
var walk_direction = 1
export var jump_impulse := 150

var gravity = 450

onready var _pivot := $Sprite
onready var _start_scale: Vector2 = _pivot.scale

func change_direction():
	if walk_direction != 0:
		walk_direction *= -1
		_pivot.scale.x = sign(walk_direction) * _start_scale.x
