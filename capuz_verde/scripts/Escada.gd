extends Area2D

func _on_EscadaArea_body_entered(body):
	Global.escada = true
func _on_EscadaArea_body_exited(body):
	Global.escada = false
