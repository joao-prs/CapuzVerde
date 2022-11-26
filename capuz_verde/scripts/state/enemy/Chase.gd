extends EnemyState

export (NodePath) var _enemy_raycast
export (NodePath) var _jump_raycast
export (NodePath) var _animation_enemy
onready var enemy_raycast: RayCast2D = get_node(_enemy_raycast)
onready var jump_raycast: RayCast2D = get_node_or_null(_jump_raycast)
onready var animation_enemy: AnimationPlayer = get_node(_animation_enemy)

var player_body: Player

func enter(_msg: = {}) -> void:
	enemy.is_chasing = true
	animation_enemy.play("Walk")

func physics_update(delta):
	if enemy.health == 0:
		state_machine.transition_to("Death")
	elif not enemy.is_chasing:
		state_machine.transition_to("Walk")
	var distance: Vector2 = enemy.position - player_body.position
	enemy.walk_direction = -sign(distance.x)
	
	
	enemy.velocity.y += enemy.gravity * delta
	enemy.velocity.x = enemy.walk_direction * enemy.speed * 1.5
	
	# Inimigo que não pula
	if jump_raycast == null:
		if enemy_raycast.is_colliding():
			state_machine.transition_to("Idle")
	elif jump_raycast != null:
		if enemy_raycast.is_colliding() and jump_raycast.is_colliding():
			state_machine.transition_to("Idle")
		elif enemy_raycast.is_colliding() and not jump_raycast.is_colliding():
			enemy.velocity.y = -enemy.jump_impulse / 2
	
	enemy.velocity = enemy.move_and_slide(enemy.velocity)

func _on_DetectChaseArea_body_entered(body):
	player_body = body
	state_machine.transition_to("Chase")


func _on_DetectChaseArea_body_exited(_body):
	enemy.is_chasing = false
	if enemy.health == 0:
		state_machine.transition_to("Death")
	else:
		state_machine.transition_to("Walk")
	
