extends Area2D

export (NodePath) var _animation_keyboard
onready var animation_keyboard: AnimationPlayer = get_node(_animation_keyboard)
export var map_local : String
var interacao = false

func _ready():
	animation_keyboard.play("Idle")

func _process(delta):
	if interacao == true and Input.is_action_pressed("f_button"):
		#pega a posicao atual da planta e passa pro jogador
		Global.player_position_x = position.x
		Global.player_position_y = position.y - 10
		#tambem salva o mapa em que o jogador esta
		Global.map_save = map_local
		#grava as variaveis globais em um arquivo em Global.gd.
		#Nao diz nesse codigo, mas tambem salva a vida do jogador
		Global.salvar_jogo()
		$Particles.emitting = true
		$TimerParticles.start()

func _on_saveArea_body_entered(body):
	interacao = true
	animation_keyboard.play("Up")
func _on_saveArea_body_exited(body):
	interacao = false
	animation_keyboard.play("Idle")


func _on_TimerParticles_timeout():
	$Particles.emitting = false
