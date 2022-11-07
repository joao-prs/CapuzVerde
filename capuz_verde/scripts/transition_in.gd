extends CanvasLayer

func change_scene(path, delay = 0.5):
	$transition_FX.interpolate_property($overlay, "progress", 0.0, 1.0, 1.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT, delay)
	$transition_FX.start()
	yield($transition_FX, "tween_completed")
	assert(get_tree().change_scene(path) == OK)
