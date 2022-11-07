extends KinematicBody2D

export var speed = 16
export var health = 2
var velocity = Vector2.ZERO
var move_direction = -1
var can_die = false

func _physics_process(delta: float)-> void:
	velocity.x = speed * move_direction
	
	velocity = move_and_slide(velocity)
	
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
	if can_die == true:
		$anim.play("dead")
		print("- morto -")
