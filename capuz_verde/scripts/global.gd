extends Node

var gravity
var player_position_x
var player_position_y
var respeito
var health : int
var food : int
var dead
var can_attack
var map_save
var can_move
var escada = false
var energia : int = 100


func _ready():
	pass

#-------------------------+
#     SALVANDO O JOGO     |
#-------------------------+
func salvar():
	var dic_salvar = {
		"player_position_x": player_position_x,
		"player_position_y": player_position_y,
		"respeito": respeito,
		"health": health,
		"map_save": map_save
	}
	return dic_salvar

func salvar_jogo():
	var jogo_salvo = File.new()
	jogo_salvo.open("user://jogosalvo.save", File.WRITE)
	#armazenar linha
	jogo_salvo.store_line(to_json(salvar()))
	jogo_salvo.close()

func carregar_jogo():
	var jogo_salvo = File.new()
	if not jogo_salvo.file_exists("user://jogosalvo.save"):
		print("Erro ao carregar o arquivo")
		return
	
	jogo_salvo.open("user://jogosalvo.save", File.READ)
	#vai ler a linha
	var linha_atual = parse_json((jogo_salvo.get_line()))
	#buscar variaveis por linha
	player_position_x = linha_atual["player_position_x"]
	player_position_y = linha_atual["player_position_y"]
	respeito = linha_atual["respeito"]
	health = linha_atual["health"]
	map_save = linha_atual["map_save"]
	jogo_salvo.close()
