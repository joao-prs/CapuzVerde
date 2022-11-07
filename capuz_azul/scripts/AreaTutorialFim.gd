extends Area2D
##
## END AREA TUTORIAL CODE
##
onready var changer = get_parent().get_node("transition_in")
export var path : String

func _ready():
	pass

func _on_AreaTutorialFim_body_entered(body):
	print(body)
	if body.name == "player":
		changer.change_scene(path)
		#changer.change_scene("res://StartScreen.tscn")
