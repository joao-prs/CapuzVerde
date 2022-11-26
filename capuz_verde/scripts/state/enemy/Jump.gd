extends EnemyState

# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		enemy.velocity.y = -enemy.jump_impulse


func physics_update(_delta: float) -> void:
	#enemy.velocity.x = enemy.speed * enemy.walk_direction
	# Vertical movement.

	# Landing.
	if enemy.is_on_floor():
		if is_equal_approx(enemy.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Walk")
