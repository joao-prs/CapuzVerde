extends EnemyState

signal enemy_direction(direction)

export (NodePath) var _animation_enemy
onready var animation_enemy: AnimationPlayer = get_node(_animation_enemy)

func enter(msg := {}) -> void:
	enemy.is_attacking = true
	animation_enemy.play("Attack")
	emit_signal("enemy_direction", enemy.walk_direction)

func physics_update(_delta):
	if not enemy.is_attacking:
		if enemy.is_chasing:
			state_machine.transition_to("Chase")
		else:
			state_machine.transition_to("Walk")


func _on_AttackArea_body_entered(body: Player):
	body.enemy_direction = enemy.walk_direction
	var state_machine = body.get_node("StateMachine")
	state_machine.transition_to("Hit")
	return


func _on_AttackArea_area_entered(area):
	var player_body = area.get_parent().get_parent()
	player_body.enemy_direction = enemy.walk_direction
	var state_machine = player_body.get_node("StateMachine")
	state_machine.transition_to("Hit")
	return
