extends Area2D
##
## RETURN MAP CODE
##
onready var changer = get_parent().get_node("transition_in")
export var path : String
#setar posicao do jogador
export var player_loc_x : float
export var player_loc_y : float

#func _ready():
#	pass	

func _on_Return_map_body_entered(body):
	if body.name == "player":
		print("[change_map.gd][corpo do jogador colidiu com a troca de mapa]")
		changer.change_scene(path)
		Global.player_position_x = player_loc_x
		Global.player_position_y = player_loc_y
