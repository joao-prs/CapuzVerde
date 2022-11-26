extends Control

onready var energy = $EnergiaBar
onready var energyTween = $EnergiaBarEscura
onready var update_tween = $Tween
var energia : int = 100
var can_recharge = false

func _process(_delta: float) -> void:

	energy.value = energia
	
	####### se houver diferença, ativa o tempo
	if Global.energia < energia:
		can_recharge = false
		ativar_daley()
		$Timer.start()

	####### se puder recarregar, ele recarrega
	energia = Global.energia

	#update_tween.start()
	if can_recharge == true:
		if energia < 100:
			Global.energia += 1
		else:
			can_recharge = false
	####### se tiver cheio, fica invisivel
	if energia == 100:
		energy.visible = false
		energyTween.visible = false
	else:
		energy.visible = true
		energyTween.visible = true

func ativar_daley():
	update_tween.interpolate_property(energyTween, "value", energyTween.value, energia, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()

####### depois de contar tempo, ele recarrega
func _on_Timer_timeout():
	can_recharge = true
