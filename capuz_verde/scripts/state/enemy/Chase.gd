extends EnemyState

export (NodePath) var _animation_enemy
onready var animation_enemy: AnimationPlayer = get_node(_animation_enemy)

var player_body: Player

func enter(_msg: = {}) -> void:
	enemy.is_chasing = true
	animation_enemy.play("Walk")

func physics_update(delta):
	if enemy.health == 0:
		state_machine.transition_to("Death")
	var distance: Vector2 = enemy.position - player_body.position
	enemy.walk_direction = -sign(distance.x)
	
	
	enemy.velocity.y += enemy.gravity * delta
	enemy.velocity.x = enemy.walk_direction * enemy.speed * 1.5
	enemy.velocity = enemy.move_and_slide(enemy.velocity)

func _on_DetectChaseArea_body_entered(body):
	player_body = body
	state_machine.transition_to("Chase")


func _on_DetectChaseArea_body_exited(body):
	enemy.is_chasing = false
	if enemy.health == 0:
		state_machine.transition_to("Death")
	else:
		state_machine.transition_to("Walk")
