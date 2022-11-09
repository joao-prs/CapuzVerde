extends Camera2D

onready var timer := $Timer as Timer
func _ready():
	timer.start()

func _on_Timer_timeout():
	print("acabou o tempo")
	smoothing_enabled = true

#  TALVEZ NO FUTURO TENHA ANIMACOES DE CAMERA,
#  PARA QUANDO O JOGADOR ATACAR OU SOFRER DANO
#  A CAMERA SACUDIR E DA UMA IMERSAO DE DESE-
#  QUILIBRIO PARA O JOGADOR..
