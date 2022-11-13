extends Control

onready var energy = $EnergiaBar
onready var energyTween = $EnergiaBarEscura
onready var update_tween = $Tween
var energia : int = 100
var can_recharge = false


func _process(_delta: float) -> void:

	energy.value = energia
	#energyTween.value = energia
	
	
	#print("debug - 1")
	#efeito
	#update_tween.interpolate_property(energyTween, "value", energyTween.value, energia, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	#update_tween.start()
	####### se houver diferença, ativa o tempo
	if Global.energia < energia:
		###
		ativar_daley()
		$Timer.start()
		#efeito

	####### se puder recarregar, ele recarrega
	energia = Global.energia

	#update_tween.start()
	if can_recharge == true:
		if energia < 100:
			Global.energia += 1
			#energy.value = energia
		else:
			can_recharge = false
	####### se tiver cheio, fica invisivel
	if energia == 100:
		energy.visible = false
		energyTween.visible = false
		#print("debug - 6")
	else:
		energy.visible = true
		energyTween.visible = true

func ativar_daley():
	update_tween.interpolate_property(energyTween, "value", energyTween.value, energia, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()

####### depois de contar tempo, ele recarrega
func _on_Timer_timeout():
	can_recharge = true
