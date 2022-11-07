extends Area2D

var interacao = false
export var map_local : String

func _process(delta):
	if interacao == true and Input.is_action_pressed("ui_up"):
		print("seta apertada pra cima")
		#pega a posicao atual da planta e passa pro jogador
		Global.player_position_x = position.x
		Global.player_position_y = position.y - 1
		Global.map_save = map_local
		Global.salvar_jogo()

func _on_saveArea_body_entered(body):
	print(body.name)
	interacao = true


func _on_saveArea_body_exited(body):
	print(body.name)
	interacao = false
