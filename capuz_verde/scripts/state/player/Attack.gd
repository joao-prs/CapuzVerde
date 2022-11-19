extends PlayerState

export (NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

export var animation: String
export var next_state: String
export var weapon: String

func enter(_msg: = {}) -> void:
	animation_player.play(animation)
	player.can_input = false

func physics_update(delta: float) -> void:
	if next_state and player.can_input and Input.is_action_just_pressed("Ataque") && Global.energia > 49:
		Global.energia -= 50
		state_machine.transition_to(next_state)
	
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

func _on_AnimationPlayer_animation_finished(_anim_name):
	if not player.is_on_floor():
		state_machine.transition_to("Jump")
		return
	else:
		if is_zero_approx(player.get_input_direction()):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Walk")
