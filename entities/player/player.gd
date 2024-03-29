class_name Player
extends CharacterBody2D

@export var speed := 100
@export var look_at_speed := 10

@onready var health_component := $HealthComponent
@onready var state_machine := $StateMachine
@onready var item_component := $ItemComponent

@onready var camera := $Camera

var is_controllable := true

func _ready():
	health_component.damaged.connect(_on_player_damaged)
	health_component.died.connect(_on_player_died)

func _physics_process(delta):
	if !is_controllable:
		return
	
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

func _on_player_damaged(value: int):
	state_machine.on_child_transition(state_machine.current_state, "hurt")

func _on_player_died():
	state_machine.on_child_transition(state_machine.current_state, "death")

func _input(event):
	if event.is_action_pressed("use") and is_controllable:
		item_component.use_item()

func _on_hurtbox_area_entered(area):
	if area is Hitbox:
		health_component.damage(area.damage)
