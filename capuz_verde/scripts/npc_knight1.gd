extends Area2D

var interacao = false
func _ready():
	pass



func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("ui_up") and interacao:
			get_tree().paused = true
			Dialogic.load("knight1")
			var novo_dialogo = Dialogic.start("knight1")
			novo_dialogo.pause_mode = Node.PAUSE_MODE_PROCESS
			Dialogic.save("knight1")
			novo_dialogo.connect("timeline_end", self, 'fim_dialogo')
			add_child(novo_dialogo)

func fim_dialogo(_timeline_name):
	get_tree().paused = false
	
func _on_npc_knight_body_entered(_body):
	#print(body.name)
	interacao = true
func _on_npc_knight_body_exited(_body):
	#print(body.name)
	interacao = false
