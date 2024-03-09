class_name Player
extends CharacterBody2D

@export var speed := 100
@export var look_at_speed := 10

@onready var health_component := $HealthComponent
@onready var state_machine := $StateMachine
@onready var item_component := $ItemComponent

func _ready():
	health_component.damaged.connect(on_player_damaged)

func _physics_process(delta):
	move_and_slide()

	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	
	# ItemComponent smooth look at
	var angle = (get_global_mouse_position() - item_component.global_position).angle()
	var rotation = item_component.global_rotation
	var angle_delta = look_at_speed * delta
	angle = lerp_angle(rotation, angle, 1.0)
	angle = clamp(angle, rotation - angle_delta, rotation + angle_delta)
	item_component.global_rotation = angle

func on_player_damaged(value: int):
	state_machine.on_child_transition(state_machine.current_state, "hurt")

func _input(event):
	if event.is_action_pressed("use"):
		item_component.use_item()
