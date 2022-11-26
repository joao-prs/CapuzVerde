extends Control
##
## ABOUT SCREEN CODE
##
func _ready():
	$HBoxContainer/btn_back.grab_focus()

func _on_btn_back_pressed():
	get_tree().change_scene("res://Scenes_map/StartScreen.tscn")
