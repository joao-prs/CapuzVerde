extends PlayerState

export (NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg: = {}) -> void:
	animation_player.play("Attack")

func physics_update(delta: float) -> void:
	if not is_zero_approx(player.get_input_direction()) and not player.is_on_floor():
		player.velocity.x = lerp(
			player.velocity.x, 
			player.get_input_direction() * player.speed, 
			player.aceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.deceleration * delta)
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(
		player.velocity, player.UP_DIRECTION
		)

func _on_AnimationPlayer_animation_finished(anim_name):
	if not player.is_on_floor():
		state_machine.transition_to("Jump")
		return
	else:
		if is_zero_approx(player.get_input_direction()):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Walk")
