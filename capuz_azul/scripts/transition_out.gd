extends CanvasLayer

func _ready():
	$transition_FX.interpolate_property($overlay, "progress", 1.0, 0.0, 2.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	$transition_FX.start()
