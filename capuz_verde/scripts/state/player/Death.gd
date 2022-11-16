extends PlayerState

export (NodePath) var _animation_player
export (NodePath) var _respawn_timer
onready var animation_player: AnimationPlayer = get_node(_animation_player)
onready var respawn_timer: Timer = get_node(_respawn_timer)

func enter(_msg: ={}) -> void:
	animation_player.play("Death")
	yield(get_tree().create_timer(2.0), "timeout")
	player.changer.load_transition()
	respawn_timer.start(1)


func _on_RespawnTimer_timeout():
	Global.death_respaw()
	get_tree().change_scene(Global.map_save)
