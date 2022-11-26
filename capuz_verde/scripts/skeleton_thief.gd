extends KinematicBody2D

export var speed : int
export var speed_subtrair : int
export var health = 2
var gravity = 450
var jump_force = -400
var velocity = Vector2.ZERO
var move_direction = -1
var can_die = false
var can_attack = true
var player_ref = null #detecta diracao player
var detectou = false

func _physics_process(delta: float)-> void:
	### FISICA DO ESKELETINHO ###
	velocity.y += gravity * delta
	### SE ELE DETECTAR JOGADOR ###
	if player_ref != null:
		detectou = true
	else:
		detectou = false
	### SE ELE MORRER ###
	if health == 0:
		can_die = true
	
	#checa se ta vivo
	if can_die != true:
		#se sim...
		if detectou == false:
			velocity.x = speed * move_direction
			velocity = move_and_slide(velocity)
			#-------------------#
			#  AGE NORMALMENTE  #
			#-------------------#
			if move_direction == 1:
				$Sprite.flip_h = false
				$Ray_wall.cast_to.y = -5
				$Ray_wall2.cast_to.y = -5
				$dano/CollisionDano.position.y = -6.5
				$detecta/CollisionDetector.position.x = 24
			else:
				$Sprite.flip_h = true
				$Ray_wall.cast_to.y = 5
				$Ray_wall2.cast_to.y = 5
				$dano/CollisionDano.position.y = 6.5
				$detecta/CollisionDetector.position.x = -24
			if velocity.x != 0:
				$anim.play("run")
				if $Ray_wall.is_colliding():
					$anim.play("idle")
			if can_attack == false:
				$anim.play("attack")
				set_physics_process(false)
		#----------------------#
		#  PERSEGUE O JOGADOR  #
		#----------------------#
		elif detectou == true:
			#print(player_ref.name," DDDD")#########
			var distance: Vector2 = position - player_ref.position
			var direction: Vector2 = distance.normalized()

			velocity.x = direction.x * (speed - speed_subtrair)
			velocity = move_and_slide(velocity)
			
			$anim.play("run")
			if direction.x < 0:
				$Sprite.flip_h = false
				$Ray_wall.cast_to.y = -5
				$Ray_wall2.cast_to.y = -5
				$dano/CollisionDano.position.y = -6.5
				$detecta/CollisionDetector.position.x = 24
				## se colidir com parede baixa, ele pula
				if $Ray_wall.is_colliding() && not $Ray_wall2.is_colliding():
					velocity.y = jump_force / 4
				if $Ray_wall.is_colliding() && $Ray_wall2.is_colliding():
					$anim.play("idle")
			else:
				$Sprite.flip_h = true
				$Ray_wall.cast_to.y = 5
				$Ray_wall2.cast_to.y = 5
				$dano/CollisionDano.position.y = 6.5
				$detecta/CollisionDetector.position.x = -24
				## se colidir com parede baixa, ele pula
				if $Ray_wall.is_colliding() && not $Ray_wall2.is_colliding():
					velocity.y = jump_force / 4
				if $Ray_wall.is_colliding() && $Ray_wall2.is_colliding():
					$anim.play("idle")
			if can_attack == false:
				$anim.play("attack")
				set_physics_process(false)

	#se nao...
	else:
		speed = 0
		$anim.play("dead")
		$dano/CollisionDano.disabled = true

func _on_anim_animation_finished(anim_name: String)-> void:
	# muda direcao do sprite e raio
	if anim_name == "idle":
		$Sprite.flip_h != $Sprite.flip_h
		$Ray_wall.scale.x *= -1
		move_direction *= -1
		$anim.play("run")
	# ataque
	if anim_name == "attack":
		set_physics_process(true)
		move_direction *= 1
		$anim.play("run")
		can_attack = true
	# deleta
	if anim_name == "dead":
		queue_free()

func _on_dano_body_entered(body):
	can_attack = false
	Global.health -= 1

func _on_corpo_area_entered(area):
	if area.is_in_group("player_ataque"):
		health -= 1
		#can_die = true
		velocity.y = jump_force / 4
		velocity.x = jump_force / 8 * move_direction
		print("skeleton thief levou dano")

#-----------------------------+
#     PROCURANDO O PLAYER     |
#-----------------------------+
func _on_detecta_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body

func _on_detecta_body_exited(body):
	if body.is_in_group("player"):
		player_ref = null
