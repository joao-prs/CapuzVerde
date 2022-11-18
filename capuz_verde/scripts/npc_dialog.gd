extends Area2D

var interacao = false
func _ready():
	pass
#transporta as variaveis pra fora
export var Dialog_timeline : String

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("ui_up") and interacao:
			get_tree().paused = true
			Dialogic.load(Dialog_timeline)
			var novo_dialogo = Dialogic.start(Dialog_timeline)
			novo_dialogo.pause_mode = Node.PAUSE_MODE_PROCESS
			Global.respeito = Dialogic.get_variable("respeito") ####
			Dialogic.save(Dialog_timeline)
			novo_dialogo.connect("timeline_end", self, 'fim_dialogo')
			add_child(novo_dialogo)

func fim_dialogo(_timeline_name):
	get_tree().paused = false
	
#corpo entrou na area
func _on_npc_body_entered(_body):
	#print(body.name)
	$AnimationPlayer.play("Up")
	interacao = true
	print("var respeito: ",Global.respeito) ####
#corpo saiu na area
func _on_npc_body_exited(_body):
	#print(body.name)
	$AnimationPlayer.play("Idle")
	interacao = false
	print("var respeito: ",Global.respeito) ####
