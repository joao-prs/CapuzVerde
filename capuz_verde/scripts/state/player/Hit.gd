extends PlayerState

export (NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg: = {}) -> void:
	animation_player.play("Hit")
	player.velocity.y = -player.jump_strength / 2
	player.velocity.x = -player.jump_strength / 2
	player.velocity = player.move_and_slide(player.velocity, player.UP_DIRECTION)

func physics_update(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0, player.deceleration * delta)
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, player.UP_DIRECTION)
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
