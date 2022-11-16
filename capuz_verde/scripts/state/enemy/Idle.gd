extends EnemyState

export (NodePath) var _animation_enemy
onready var animation_enemy: AnimationPlayer = get_node(_animation_enemy)
onready var timer := $Timer as Timer

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	enemy.velocity = Vector2.ZERO
	animation_enemy.play("Idle")
	timer.start(2)

func update(_delta: float) -> void:
	# If you have platforms that break when standing on them, you need that check for 
	# the character to fall.
	if not enemy.is_on_floor():
		state_machine.transition_to("Air")
		return

func _on_Timer_timeout():
	if not enemy.is_dead:
		enemy.change_direction()
		state_machine.transition_to("Walk")
		return
	return


func _on_CollisionArea_area_entered(area):
	state_machine.transition_to("Death")
