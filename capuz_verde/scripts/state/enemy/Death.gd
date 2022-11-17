extends EnemyState

export (NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg: = {}) -> void:
	enemy.is_dead = true
	animation_player.play("Death")

func physics_update(delta):
	enemy.velocity.x = lerp(enemy.velocity.x, 0, enemy.speed * delta)
	enemy.velocity = enemy.move_and_slide(enemy.velocity)
