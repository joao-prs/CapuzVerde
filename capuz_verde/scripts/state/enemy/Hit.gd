extends EnemyState

export (NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg: = {}) -> void:
	var player_direction = get_parent().get_parent().get_parent().get_node("WIPPlayer").player_direction
	enemy.health -= 1
	animation_player.play("Hit")
	enemy.walk_direction = -player_direction
	enemy.velocity.x = enemy.speed * 10 * player_direction
	if enemy.health == 0:
		state_machine.transition_to("Death")
	else:
		yield(get_tree().create_timer(0.5), "timeout")
		if enemy.is_chasing:
			state_machine.transition_to("Chase")
		else:
			state_machine.transition_to("Walk")

func physics_update(delta):
	enemy.velocity.x = lerp(enemy.velocity.x, 0, enemy.speed * delta)
	enemy.velocity = enemy.move_and_slide(enemy.velocity)
	
