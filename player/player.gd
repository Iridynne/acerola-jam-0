class_name Player
extends CharacterBody2D

@export var speed := 100

func _physics_process(delta):
	move_and_slide()

	if velocity.x > 0:
		$Sprite2D.flip_h = false
	elif velocity.x < 0:
		$Sprite2D.flip_h = true
