extends Area2D

var interacao = false
func _ready():
	pass

var novo_dialogo
var wr

func _process(delta):
	if interacao == true and Input.is_action_pressed("ui_up"):
		Global.can_move = false
		print("seta apertada pra cima")
		#busca valor no global
		##Dialogic.set_variable("respeito", Global.respeito)
		Dialogic.load("chill1")
		novo_dialogo = Dialogic.start("chill1")
		#Global.respeito = Dialogic.get_variable("respeito")
		#Global.respeito = Dialogic.get_current_slot()
		#Dialogic.get_variable("respeito",Global.respeito  )
		Dialogic.save("chill1")
		add_child(novo_dialogo)

		interacao = false
		
func _physics_process(delta: float) -> void:
	#var1 = typeof(novo_dialogo)
	#print(wr)
	wr = weakref(novo_dialogo)
	if not wr.get_ref():
		Global.can_move = true
	
#corpo entrou na area
func _on_npc_body_entered(body):
	#print(body.name)
	interacao = true
#corpo saiu na area
func _on_npc_body_exited(body):
	#print(body.name)
	interacao = false
