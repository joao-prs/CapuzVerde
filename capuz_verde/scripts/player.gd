extends KinematicBody2D

onready var changer = get_parent().get_node("transition_in")
# variaveis fisica e movimentos
var velocity = Vector2.ZERO
var move_speed = 60
var gravity = 450
var jump_force = -400
var move_direction : int
var direction:int = 1
# variaveis estados do personagem
var anim
var dead
var health : int
# variaveis referenciando o collision de atack
var can_attack
var levou_dano = false
onready var collision: CollisionShape2D = get_node("AreaDeAtack/Collision")
onready var timer := $Timer as Timer

################################
# MAQUINA DE ESTADOS DO PLAYER #
################################
signal state_change

var state_stack = []
var current_state = null

onready var state_map = {
	'idle': $States/Idle,
	'move': $States/Move,
	'jump': $States/Jump,
	'hit': $States/Hit
}

func _ready():
	state_stack.push_front($States/Idle)
	current_state = state_stack[0]
	#_change_state('idle')
	
	dead = false
	anim = "idle"
	position.x = Global.player_position_x
	position.y = Global.player_position_y

func _physics_process(delta):
	var state_name = current_state.update(self, delta)
	if state_name:
		#_change_state(state_name)
	
	health = Global.health
	can_attack = true
	
	velocity.y += gravity * delta
	velocity.x = 0
	
	if health > Global.health:
		timer.start()
		print("[player.gd] levou dano --->") #####
		velocity.y = jump_force / 4
		$Sprite.modulate = "ff7a7a"
		
	move_direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	velocity.x = move_speed * move_direction
	
	if velocity.x > 0:
		$Sprite.flip_h = false
		collision.position = Vector2(6, -8)
	elif velocity.x < 0:
		$Sprite.flip_h = true
		collision.position = Vector2(-6, -8)
		
	
	############ funcoes sempre rodando
	velocity = move_and_slide(velocity, Vector2(0, -1))
	_set_animation()
	

func _unhandled_input(event):
	if event.is_action_pressed("ui_select") && is_on_floor():
		velocity.y = jump_force /2
		return
	elif event.is_action_pressed("Ataque") && is_on_floor():
		can_attack = false
		_set_animation()
		return

func _set_animation():
	#pode se mexer?
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
		print("[player.gd][YOU DIED]")
		changer.change_scene(Global.map_save)
		Global.carregar_jogo()

func _on_Collision_tree_entered():
	if $Collision.is_in_group("ataque_inimigo"):
		dead = true

func _on_Timer_ready():
	# Essa funcao deveria deslocar o jogador
	# para o lado oposto ao dano.
	velocity.x = (move_speed) * (direction)

func _on_Timer_timeout():
	$Sprite.modulate = "ffffff"
