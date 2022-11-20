extends Area2D

export (NodePath) var _animation_keyboard
onready var animation_keyboard: AnimationPlayer = get_node(_animation_keyboard)
#transporta as variaveis pra fora
export var Dialog_timeline : String
var interacao = false
func _ready():
	animation_keyboard.play("Idle")

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("ui_up") and interacao:
			get_tree().paused = true
			Dialogic.load(Dialog_timeline)
			var novo_dialogo = Dialogic.start(Dialog_timeline)
			Dialogic.set_variable("respeito", Global.respeito) #### seta a variavel pra dentro do dialogo
			novo_dialogo.pause_mode = Node.PAUSE_MODE_PROCESS
			Dialogic.save(Dialog_timeline)
			novo_dialogo.connect("timeline_end", self, 'fim_dialogo')
			add_child(novo_dialogo)

func fim_dialogo(_timeline_name):
	Global.respeito = Dialogic.get_variable("respeito") #### captura a variavel dentro do dialogo
	get_tree().paused = false

func _on_npc_body_entered(_body): #corpo entrou na area
	#print(body.name)
	$AnimationPlayer.play("Up")
	interacao = true
	print("var respeito: ",Global.respeito) ####

func _on_npc_body_exited(_body): #corpo saiu na area
	#print(body.name)
	$AnimationPlayer.play("Idle")
	interacao = false
	print("var respeito: ",Global.respeito) ####
