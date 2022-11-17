extends EnemyState

signal enemy_direction(direction)

export (NodePath) var _animation_enemy
onready var animation_enemy: AnimationPlayer = get_node(_animation_enemy)

export var is_attacking = false

func enter(msg := {}) -> void:
	is_attacking = true
	animation_enemy.play("Attack")
	emit_signal("enemy_direction", enemy.walk_direction)

func physics_update(_delta):
	if !is_attacking:
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
