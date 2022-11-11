extends CanvasLayer

# func _ready():
	#$VBoxContainer/returnMenu.grab_focus()
	#print("pause")
var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("ui_end"):
		$VBoxContainer/resume.grab_focus()
		print("pause")
		self.is_paused = !is_paused 

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_resume_pressed():
	self.is_paused = false
	print("no pause")

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://StartScreen.tscn")
