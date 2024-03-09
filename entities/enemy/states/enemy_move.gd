class_name EnemyMove
extends State

@export var enemy: Enemy
@export var sprite: AnimatedSprite2D

var direction

func enter():
	print("Enemy entered state: " + name.to_lower())
	sprite.play("walk")
	pass

func update(_delta: float):
	pass

func physics_update(delta: float):
	pass

func exit():
	pass
