extends Control

onready var energy = $EnergiaBar
var energia : int = 100
var can_recharge = false

func _process(_delta: float) -> void:

	energy.value = energia
	####### se houver diferença, ativa o tempo
	if Global.energia < energia:
		$Timer.start()
	####### se puder recarregar, ele recarrega
	energia = Global.energia
	if can_recharge == true:
		if energia < 100:
			Global.energia += 1
			energy.value = energia
		else:
			can_recharge = false
	####### se tiver cheio, fica invisivel
	if energia >= 99:
		energy.visible = false
	else:
		energy.visible = true

####### depois de contar tempo, ele recarrega
func _on_Timer_timeout():
	can_recharge = true
