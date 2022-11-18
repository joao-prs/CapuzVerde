extends Area2D

export (NodePath) var _animation_keyboard
onready var animation_keyboard: AnimationPlayer = get_node(_animation_keyboard)

var interacao = false
func _ready():
	animation_keyboard.play("Idle")

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("ui_up") and interacao:
			get_tree().paused = true 
			Dialogic.load("chill1")
			var novo_dialogo = Dialogic.start("chill1")
			Dialogic.set_variable("respeito", Global.respeito) #### seta a variavel pra dentro do dialogo
			novo_dialogo.pause_mode = Node.PAUSE_MODE_PROCESS
			Dialogic.save("chill1")
			novo_dialogo.connect("timeline_end", self, 'fim_dialogo')
			add_child(novo_dialogo)

func fim_dialogo(_timeline_name):
	Global.respeito = Dialogic.get_variable("respeito") #### captura a variavel dentro do dialogo
	get_tree().paused = false

func _on_npc_body_entered(_body):
	print(animation_keyboard)
	animation_keyboard.play("Up")
	interacao = true
	print("var respeito: ",Global.respeito) ####$$$ testando 
#corpo saiu na area

func _on_npc_body_exited(_body):
	#print(body.name)
	animation_keyboard.play("Idle")
	interacao = false
	print("var respeito: ",Global.respeito) ####$$$ testando
