class_name EnemyFollow
extends State

@onready var player = get_tree().get_first_node_in_group("player")

@export var enemy: Enemy
@export var sprite: AnimatedSprite2D

func enter():
	sprite.play("move")
	pass

func physics_update(delta: float):
	if !player.health_component.is_alive:
		transitioned.emit(self, "idle")
	
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 16:
		enemy.velocity = direction.normalized() * enemy.speed
	else:
		enemy.velocity = Vector2.ZERO
		transitioned.emit(self, "attack")
