extends KinematicBody2D

onready var changer = get_parent().get_node("transition_in")
#fisica e movimentos
var velocity = Vector2.ZERO
var move_speed = 60
var gravity = 750
var jump_force = -475
var is_grounded
onready var raycasts = $raycasts

var can_move = true
#estados do personagem
var anim
var dead
var health
# referenciando o collision de atack
var can_attack
onready var collision: CollisionShape2D = get_node("AreaDeAtack/Collision")


func _ready():
	dead = false
	anim = "idle"
	position.x = Global.player_position_x
	position.y = Global.player_position_y

func _physics_process(delta: float) -> void:

	velocity.y += gravity * delta
	#can_attack = Global.can_attack
	health = Global.health
	can_move = Global.can_move
	can_attack = true
	_get_input()
	velocity = move_and_slide(velocity)
	is_grounded = _check_is_ground()
	attack()
	_set_animation()
	#print("health:",health,",animation:",anim,",dead:",dead,",mapa:",Global.map_save,",respeito:", Global.respeito)
func _get_input():
	velocity.x = 0
	#if can_move==true:
	var move_direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	#
	# arrumar essa poha de baixo
	#
	#velocity.x = lerp(velocity.x, move_speed * move_direction, 0.02)
	velocity.x = move_speed * move_direction
	
	if velocity.x > 0:
		$Sprite.flip_h = false
		collision.position = Vector2(6, -8)
	elif velocity.x < 0:
		$Sprite.flip_h = true
		collision.position = Vector2(-6, -8)


func attack() -> void:
	if Input.is_action_just_pressed("Ataque") and can_attack == true && is_grounded:
		can_attack = false
		print("1° anim:",anim,"  can_attack:",can_attack) # TESTANDO ATTTACKK
	

func _input(event: InputEvent) -> void:
	#"ui_select = tecla espaço"
	if event.is_action_pressed("ui_select") && is_grounded:
		velocity.y = jump_force / 2

func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func _set_animation():
	#pode se mexer?
	if can_move == false:
		set_physics_process(false)
	else:
		set_physics_process(true)
		if health > 0:
			if velocity.x == 0:
				anim = "idle"
			elif velocity.x != 0:
				anim = "run"
				#$anim.play("run")

		if can_attack == false:
			anim = "attack"
			set_physics_process(false)
			print("2° anim:",anim,"  can_attack:",can_attack) # TESTANDO ATTTACKK

		elif health < 1:
			anim = "dead"
			dead = true
			set_physics_process(false)

		if $anim.assigned_animation != anim:
			$anim.play(anim)

# verifica se a animacao acabou
func _on_anim_animation_finished(animation):
	if animation == "attack":
		can_attack = true
		set_physics_process(true)
		#can_move = true
		print("3° anim:",animation,"  can_attack:",can_attack,"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa") # TESTANDO ATTTACKK
		
	if animation == "dead":
		#get_tree().reload_current_scene()
		#get_tree().change_scene("res://StartScreen.tscn")
		#get_tree().change_scene(Global.map_save)
		changer.change_scene(Global.map_save)
		Global.health = 1
		Global.carregar_jogo()


