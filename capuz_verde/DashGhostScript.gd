extends Sprite

func _ready():
	get_node("Tween").interpolate_property(self, "modulate:a", 1, 0.0, 0.8, 1, 1)
	get_node("Tween").start()

<<<<<<< HEAD
func _on_Tween_tween_all_completed():
=======

func _on_Tween_tween_completed(_object, _key):
>>>>>>> 7efe69f74d61b7cb4818011a77d8384bed3372db
	queue_free()
