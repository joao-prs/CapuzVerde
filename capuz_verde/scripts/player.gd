extends KinematicBody2D

onready var changer = get_parent().get_node("transition_in")
# variaveis fisica e movimentos
var velocity = Vector2.ZERO
var move_speed = 60
var gravity = 450
var jump_force = -400
var acceleration = 5
var move_direction : int
var direction:int = 1
var can_move = true
# variaveis estados do personagem
var anim
var dead
var health : int
# variaveis referenciando o collision de atack
var can_attack
var energia = Global.energia
var animacao_dano = false
onready var collision: CollisionShape2D = get_node("AreaDeAtack/Collision")
onready var timer := $Timer as Timer
# variaveis do dash
var dash_ghost_scene = preload("res://DashGhost.tscn")


func ghost_spawn():
	var ghost: Sprite = dash_ghost_scene.instance()
	
	ghost.position.x = $Sprite.position.x
	ghost.position.y = $Sprite.position.y
	
	print(ghost.position)
	get_parent().get_parent().add_child(ghost)
	
func _ready():
	dead = false
	anim = "idle"
	position.x = Global.player_position_x
	position.y = Global.player_position_y

func _physics_process(delta):
	can_attack = true
	
	velocity.y += gravity * delta
	

	move_direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if !animacao_dano:
		if move_direction == 0:
			if velocity.x > 0:
				velocity.x -= acceleration
				if velocity.x < 5:
					velocity.x = 0
			elif velocity.x < 0:
				velocity.x += acceleration
				if velocity.x > -5:
					velocity.x = 0
		else:
			velocity.x = move_speed * move_direction


	if velocity.x > 0 && !animacao_dano:
		$Sprite.flip_h = false
		collision.position = Vector2(6, -8)
	elif velocity.x < 0 && !animacao_dano:
		$Sprite.flip_h = true
		collision.position = Vector2(-6, -8)
	
	if health > Global.health:
		timer.start(0.5)
		if $Sprite.flip_h:
			move_direction = -1
		else:
			move_direction = 1
		print("[player.gd] levou dano --->") #####
		velocity.y = jump_force / 4
		velocity.x = jump_force / 8 * move_direction
		animacao_dano = true
		print(velocity)
		$Sprite.modulate = "ff7a7a"
		
	health = Global.health
	
	############ funcoes sempre rodando
	velocity = move_and_slide(velocity, Vector2.UP)
	_escada()
	_set_animation()


func _unhandled_input(event):
	if event.is_action_pressed("ui_select") && is_on_floor():
		velocity.y = jump_force /2
		return
	elif event.is_action_pressed("Ataque") && is_on_floor() && Global.energia > 49:
		can_attack = false
		Global.energia -= 50
		_set_animation()
		return

	elif event.is_action_pressed("dash"):
		Dash()

#---------------+
#  PULO / TECLA |
#---------------+
func _input(event: InputEvent) -> void:
	#"ui_select = tecla espaço"
	if event.is_action_pressed("ui_select") && is_on_floor():
		velocity.y = jump_force / 2


func _set_animation():
	#------------------+
	#  PODE SE MOVER?  |
	#------------------+
	set_physics_process(true)
	if health > 0:
		if velocity.x == 0:
			anim = "idle"
		elif velocity.x != 0:
			anim = "run"
	if can_attack == false:
		anim = "attack"
		set_physics_process(false)
	elif health < 1:
		anim = "dead"
		dead = true
		$Collision.disabled = true
		set_physics_process(false)

	if $anim.assigned_animation != anim:
		$anim.play(anim)

func _on_anim_animation_finished(animation):
	if animation == "attack":
		can_attack = true
		set_physics_process(true)
		
	if animation == "dead":
		Global.death_respaw()
		changer.change_scene(Global.map_save)
		Global.death_respaw()

func _on_Collision_tree_entered():
	if $Collision.is_in_group("ataque_inimigo"):
		dead = true

func _on_Timer_ready():
	# Essa funcao deveria deslocar o jogador
	# para o lado oposto ao dano.
	velocity.x = (move_speed) * (direction)

func _on_Timer_timeout():
	$Sprite.modulate = "ffffff"
	animacao_dano = false
#--------------------+
#  TESTE DO GUSTAVO  |
#--------------------+
func Dash():
	# só aplicar o dash quando tiver andando
	if velocity.x:
		move_speed = 180
		# verificar em qual direcao vai ser o dash
		if $Sprite.flip_h:
			$Dash_particle.position.x = 10
		else:
			$Dash_particle.position.x = -10
			
		print("Dash?")
		$Dash_timer.start()
		$Dash_particle.emitting = true
	
func _on_Dash_timer_timeout():
	$Dash_particle.emitting = false
	print("CABO")
	move_speed = 60

#-----------------------------------------+
#  MECANICA DE SUBIR E DESCER EM ESCADAS  |
#-----------------------------------------+
func _escada():
	if Global.escada == true:
		print("escada")
		velocity.y = 0
		if int(Input.is_action_pressed("ui_up")):
			print("subindo escada")
			velocity.y = move_speed * -1
		if int(Input.is_action_pressed("ui_down")):
			print("descendo escada")
			velocity.y = move_speed * 1
		gravity = 200
	else:
		gravity = 450
