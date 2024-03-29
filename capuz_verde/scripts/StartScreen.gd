extends Control
##
## START SCREEN CODE
##
func _ready():
	$VBoxContainer/btn_start.grab_focus()

func _on_btn_start_pressed():
	Global.carregar_jogo()
	#-------------------------+
	#     TROCANDO O MAPA     |
	#-------------------------+
	# variaveis iniciais temporarias
	# para caso o jogo não tenha elas
	if not Global.player_position_x:
		Global.player_position_x = 42
	if not Global.player_position_y:
		Global.player_position_y = 95
	if not Global.health:
		Global.health = 3
	if not Global.respeito:
		Global.respeito = 1
	if not Global.food:
		Global.food = 0
	if not Global.map_save:
		Global.map_save = "res://Scenes_map/level1.tscn"

	get_tree().change_scene(Global.map_save)
	print(Global.map_save)

func _on_btn_tutorial_pressed():
	if not Global.health:
		Global.health = 3
	get_tree().change_scene("res://Scenes_map/tutorial.tscn")
	Global.player_position_x = 256
	Global.player_position_y = 64

func _on_btn_about_pressed():
	get_tree().change_scene("res://Scenes/AboutScreen.tscn")

func _on_btn_quit_pressed():
	get_tree().quit()
