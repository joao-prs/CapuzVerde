class_name HitBox
extends Area2D

export var dano := 1

func _init():
	collision_layer = 64
	collision_mask = 0
