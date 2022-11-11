extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed = 60
export var acceleration = 5

export var jump_strength = 200
export var gravity = 450

var _velocity := Vector2.ZERO

onready var _pivot := $Sprite
onready var _animation_player := $anim
onready var _start_scale: Vector2 = _pivot.scale

func _physics_process(delta):
	var _horizontal_direction = (
		Input.get_action_strength("ui_right")
		- Input.get_action_strength("ui_left")
	)
	if _horizontal_direction == 0:
		if _velocity.x > 0:
			_velocity.x -= acceleration
		elif _velocity.x < 0:
			_velocity.x += acceleration
	else:
		_velocity.x = _horizontal_direction * speed
	_velocity.y += gravity * delta
	
	var is_falling := +_velocity.y > 0 and not is_on_floor()
	var is_jumping := Input.is_action_just_pressed("ui_select") and is_on_floor()
	var is_jump_cancelled := Input.is_action_just_released("ui_accept") and _velocity.y < 0
	var is_idling := is_on_floor() and is_zero_approx(_velocity.x)
	var is_running := is_on_floor() and not is_zero_approx(_velocity.x)
	
	if is_jumping:
		_velocity.y = -jump_strength
	elif is_jump_cancelled:
		_velocity.y = _velocity.y / 2
		
	_velocity = move_and_slide(_velocity, UP_DIRECTION)
	
	if not is_zero_approx(_velocity.x):
		_pivot.scale.x = sign(_velocity.x) * _start_scale.x
	
	if is_running:
		_animation_player.play("run")
	elif is_idling:
		_animation_player.play("idle")
