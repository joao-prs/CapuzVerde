extends Sprite

func _ready():
	get_node("Tween").interpolate_property(self, "modulate:a", 1, 0.0, 0.8, 1, 1)
	get_node("Tween").start()

func _on_Tween_tween_all_completed():
	queue_free()
