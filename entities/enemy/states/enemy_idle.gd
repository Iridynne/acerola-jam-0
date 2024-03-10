class_name EnemyIdle
extends State

@onready var player = get_tree().get_first_node_in_group("player")

@export var enemy: Enemy
@export var sprite: AnimatedSprite2D

func enter():
	sprite.play("idle")
	pass

func update(_delta: float):
	if !player.health_component.is_alive:
		return
	
	var direction = player.global_position - enemy.global_position
	if direction.length() < enemy.detection_range:
		transitioned.emit(self, "follow")
