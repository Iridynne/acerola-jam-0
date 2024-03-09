class_name Enemy
extends CharacterBody2D

@export var speed := 100

@onready var health_component := $HealthComponent
@onready var state_machine := $StateMachine

func _ready():
	health_component.damaged.connect(on_enemy_damaged)

func _physics_process(delta):
	move_and_slide()

	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true

func on_enemy_damaged(value: int):
	state_machine.on_child_transition(state_machine.current_state, "hurt")
