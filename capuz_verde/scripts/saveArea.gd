extends Area2D

var interacao = false
export var map_local : String

func _process(delta):
	if interacao == true and Input.is_action_pressed("ui_up"):
		#printa no console informaçoes pertinentes que foram gravadas
		print("[saveArea.gd][ HP: ",Global.health," ]")
		
		#pega a posicao atual da planta e passa pro jogador
		Global.player_position_x = position.x
		Global.player_position_y = position.y - 1
		#tambem salva o mapa em que o jogador esta
		Global.map_save = map_local
		#grava as variaveis globais em um arquivo em Global.gd.
		#Nao diz nesse codigo, mas tambem salva a vida do jogador
		Global.salvar_jogo()

func _on_saveArea_body_entered(body):
	interacao = true
func _on_saveArea_body_exited(body):
	interacao = false
