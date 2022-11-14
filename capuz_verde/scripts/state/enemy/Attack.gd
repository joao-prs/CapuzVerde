extends EnemyState

export (NodePath) var _animation_enemy
onready var animation_enemy: AnimationPlayer = get_node(_animation_enemy)

export var is_attacking = false

func enter(msg := {}) -> void:
	is_attacking = true
	animation_enemy.play("Attack")

func physics_update(_delta):
	if !is_attacking:
		state_machine.transition_to("Walk")
