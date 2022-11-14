extends PlayerState

export (NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(msg: = {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_strength
		animation_player.play("Jump")

func physics_update(delta: float) -> void:
	if Input.is_action_just_released("ui_accept") and player.velocity.y < 0:
		player.velocity.y = player.velocity.y / 2
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(
			player.velocity.x, 
			player.get_input_direction() * player.speed, 
			player.aceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.deceleration * delta)
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, player.UP_DIRECTION)
	
	if Input.is_action_just_pressed("Ataque"):
		state_machine.transition_to("FirstAttack")
	
	if player.is_on_floor():
		if is_zero_approx(player.get_input_direction()):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Walk")
