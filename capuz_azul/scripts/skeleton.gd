extends KinematicBody2D

export var speed = 16
export var health = 2
var velocity = Vector2.ZERO
var move_direction = -1
var can_die = false

func _physics_process(delta: float)-> void:
	velocity.x = speed * move_direction
	
	velocity = move_and_slide(velocity)
	
	#checa se ta vivo
	if can_die != true:
		#se sim...
		if move_direction == 1:
			$Sprite.flip_h = false
			$Ray_wall.cast_to.y = -5
			$dano/CollisionDano.position.y = -4
		else:
			$Sprite.flip_h = true
			$Ray_wall.cast_to.y = 5
			$dano/CollisionDano.position.y = 4
		if velocity.x != 0:
			$anim.play("run")
			if $Ray_wall.is_colliding():
				$anim.play("idle")
				print(velocity.x, " parado")
	#se nao...
	else:
		speed = 0
		$anim.play("dead")
		print("- morto -")

func _on_anim_animation_finished(anim_name: String)-> void:
	# muda direcao do sprite e raio
	if anim_name == "idle":
		$Sprite.flip_h != $Sprite.flip_h
		$Ray_wall.scale.x *= -1
		move_direction *= -1
		$anim.play("run")
	# deleta
	if anim_name == "dead":
		queue_free()

func _on_dano_body_entered(body):
	Global.health = 0
	Global.can_attack = true

func _on_corpo_area_entered(area):
	print("area detectada")
	if area.is_in_group("player_ataque"):
		can_die = true
		print("bot morreu")
