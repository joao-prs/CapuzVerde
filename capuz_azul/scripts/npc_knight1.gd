extends Area2D

var interacao = false
func _ready():
	pass

func _process(delta):
	if interacao == true and Input.is_action_pressed("ui_up"):
		print("seta apertada pra cima")
		#busca valor no global
		Dialogic.load()
		var novo_dialogo = Dialogic.start("knight1")
		Dialogic.save()
		
		add_child(novo_dialogo)
		#finaliza
		interacao = false


func _on_npc_knight_body_entered(body):
	#print(body.name)
	interacao = true
func _on_npc_knight_body_exited(body):
	#print(body.name)
	interacao = false
