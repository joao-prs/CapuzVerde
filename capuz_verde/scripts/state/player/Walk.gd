extends PlayerState

export (NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg: = {}) -> void:
	animation_player.play("Walk")

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Jump")
		return
	
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(
			player.velocity.x, 
			player.get_input_direction() * player.speed, 
			player.aceleration * delta)
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, player.UP_DIRECTION)
	
	if Input.is_action_just_pressed("ui_select"):
		state_machine.transition_to("Jump", {do_jump = true})
	elif Input.is_action_just_pressed("Ataque"):
		state_machine.transition_to("FirstAttack")
	elif Input.is_action_just_pressed("dash") && Global.energia >= 50:
		Global.energia -= 50
		state_machine.transition_to("Dash")
	elif is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Idle")
