extends KinematicBody2D

export var speed = 16
export var health = 2
var gravity = 450
var jump_force = -400
var velocity = Vector2.ZERO
var move_direction = -1
var is_alive = true
var can_attack = true

func _physics_process(delta: float)-> void:
	### FISICA DO ESKELETINHO ###
	velocity.y += gravity * delta
	###
	velocity.x = speed * move_direction
	velocity = move_and_slide(velocity)
	
	#checa se ta vivo
	if is_alive:
		#se sim...
		#-------------------#
		#  AGE NORMALMENTE  #
		#-------------------#
		if move_direction == 1:
			$Sprite.flip_h = false
			$Ray_wall.cast_to.y = -5
			$dano/CollisionDano.position.y = -6.5
		else:
			$Sprite.flip_h = true
			$Ray_wall.cast_to.y = 5
			$dano/CollisionDano.position.y = 6.5
		if velocity.x != 0:
			$anim.play("run")
			if $Ray_wall.is_colliding():
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
		#$Sprite.flip_h = true
		$Ray_wall.scale.x *= -1
		move_direction *= -1
		$anim.play("run")
	# ataque
	if anim_name == "attack":
		set_physics_process(true)
		move_direction *= 1
		$anim.play("idle")
		can_attack = true
	# deleta
	if anim_name == "dead":
		queue_free()

func _on_dano_body_entered(_body):
	can_attack = false
	Global.health -= 1
	Global.can_attack = true

func _on_corpo_area_entered(area):
	if area.is_in_group("player_ataque"):
		is_alive = false
		health -= 1
		#can_die = true
		velocity.y = jump_force / 4
		velocity.x = jump_force / 8 * move_direction
		print("skeleton thief levou dano")
