extends CanvasLayer

func _process(delta: float)-> void:
	$HBoxContainer/Heart/value.text = String(Global.health)
	$HBoxContainer/Food/value.text = String(Global.food)
