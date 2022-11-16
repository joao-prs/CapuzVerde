extends PlayerState

export (NodePath) var _animation_player
onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg: = {}) -> void:
	animation_player.play("Idle")
	
func update(_delta):
	if player.health == 0:
		state_machine.transition_to("Death")

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Jump")
		return
	
	player.velocity.x = lerp(player.velocity.x, 0, player.deceleration * delta)
	player.velocity = player.move_and_slide(
		player.velocity, player.UP_DIRECTION
		)
	
	if Input.is_action_just_pressed("ui_select"):
		state_machine.transition_to("Jump", {do_jump = true})
	elif Input.is_action_just_pressed("Ataque"):
		state_machine.transition_to("FirstAttack")
	elif not is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Walk")


func _on_HurtBoxArea_area_entered(area):
	state_machine.transition_to("Hit")
