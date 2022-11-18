class_name Enemy
extends KinematicBody2D

export var health = 1
export var speed := 16
export var walk_direction = 1
export var jump_impulse := 150
var velocity := Vector2.ZERO
var is_dead = false
var is_chasing = false
export var is_attacking = false
var gravity = 450

onready var _pivot := $Sprite
onready var _start_scale: Vector2 = _pivot.scale

func change_direction():
	if walk_direction != 0:
		walk_direction *= -1
		_pivot.scale.x = sign(walk_direction) * _start_scale.x

func _physics_process(_delta):
	if walk_direction != 0:
		_pivot.scale.x = sign(walk_direction) * _start_scale.x
