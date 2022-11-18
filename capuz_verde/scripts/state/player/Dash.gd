extends PlayerState

export (NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg: ={}) -> void:
	player.dash_particle.emitting = true
	animation_player.play("Dash")
	yield(get_tree().create_timer(0.3), "timeout")
	player.dash_particle.emitting = false
	state_machine.transition_to("Idle")

func physics_update(dash):
	player.velocity.y = 0
	player.velocity.x = player.player_direction * player.speed * 2.5
	player.velocity = player.move_and_slide(player.velocity)
