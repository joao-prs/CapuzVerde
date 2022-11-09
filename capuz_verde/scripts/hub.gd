extends CanvasLayer

func _process(delta: float)-> void:
	$Control/value.text = String(Global.health)
