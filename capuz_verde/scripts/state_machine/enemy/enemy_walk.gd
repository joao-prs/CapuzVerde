extends EnemyState

export (NodePath) var _enemy_raycast
export (NodePath) var _animation_enemy
onready var enemy_raycast: RayCast2D = get_node(_enemy_raycast)
onready var animation_enemy: AnimationPlayer = get_node(_animation_enemy)


func enter(_msg := {}) -> void:
	animation_enemy.play("Walk")

func physics_update(delta: float) -> void:
	enemy.get_direction()

	enemy.velocity.x = enemy.speed * enemy.walk_direction
	enemy.velocity.y += enemy.gravity * delta
	enemy.velocity = enemy.move_and_slide(enemy.velocity, Vector2.UP)
	
	if not enemy.is_on_floor():
		state_machine.transition_to("Air")
		return

	if enemy_raycast.is_colliding():
		state_machine.transition_to("Idle")
