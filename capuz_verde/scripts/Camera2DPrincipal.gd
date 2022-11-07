extends Camera2D

onready var timer := $Timer as Timer
func _ready():
	#position.x = Global.cam_position_x
	#position.y = Global.cam_position_y
	timer.start()

#func _physics_process(delta: float) -> void:
	#print(smoothing_enabled)
	


func _on_Timer_timeout():
	print("acabou o tempo")
	smoothing_enabled = true
