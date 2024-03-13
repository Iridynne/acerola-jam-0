class_name EnemyFollow
extends State

@onready var player = get_tree().get_first_node_in_group("player")

@export var enemy: Enemy
@export var sprite: AnimatedSprite2D
@export var nav_agent: NavigationAgent2D
@export var nav_timer: Timer

func enter():
	nav_timer.timeout.connect(_on_timeout)
	sprite.play("move")
	nav_timer.start()
	pass

func physics_update(delta: float):
	if !player or !player.health_component.is_alive:
		transitioned.emit(self, "idle")
		return
	
	var direction = enemy.to_local(nav_agent.get_next_path_position())
	
	if direction.length() > 16:
		enemy.velocity = direction.normalized() * enemy.speed
	else:
		enemy.velocity = Vector2.ZERO
		transitioned.emit(self, "attack")

func exit():
	nav_timer.timeout.disconnect(_on_timeout)
	nav_timer.stop()

func _on_timeout():
	nav_agent.target_position = player.global_position
