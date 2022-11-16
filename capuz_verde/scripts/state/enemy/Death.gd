extends EnemyState

export (NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg: = {}) -> void:
	enemy.is_dead = true
	animation_player.play("Death")
