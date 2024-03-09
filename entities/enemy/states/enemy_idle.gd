class_name EnemyIdle
extends State

@export var sprite: AnimatedSprite2D

func enter():
	print("Enemy entered state: " + name.to_lower())
	sprite.play("idle")
	pass

func update(_delta: float):
	pass
