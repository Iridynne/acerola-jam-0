class_name EnemyIdle
extends State

@onready var player = get_tree().get_first_node_in_group("player")

@export var enemy: Enemy
@export var sprite: AnimatedSprite2D
@export var nav_agent: NavigationAgent2D

func enter():
	sprite.play("idle")
	pass

func update(_delta: float):
	if !player or !player.health_component.is_alive:
		return
	
	nav_agent.target_position = player.global_position
	var direction = enemy.to_local(nav_agent.get_next_path_position())
	if direction.length() < enemy.detection_range:
		transitioned.emit(self, "follow")
