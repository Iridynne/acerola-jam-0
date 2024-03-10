class_name Enemy
extends CharacterBody2D

@export var speed := 80
@export var detection_range := 96

@onready var sprite := $AnimatedSprite2D
@onready var health_component := $HealthComponent
@onready var state_machine := $StateMachine
@onready var hurt_box := $Hurtbox

@onready var damage_timer := $DamageTimer

var area_hitbox: Hitbox

func _ready():
	health_component.damaged.connect(_on_enemy_damaged)
	health_component.died.connect(_on_enemy_died)

func _physics_process(delta):
	move_and_slide()

	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true

func _on_enemy_damaged(value: int):
	state_machine.on_child_transition(state_machine.current_state, "hurt")

func _on_enemy_died():
	queue_free()

func _on_hurtbox_area_entered(hitbox: Hitbox):
	if hitbox == null:
		return

	area_hitbox = hitbox
	health_component.damage(area_hitbox.damage)
	damage_timer.timeout.connect(_on_area_damage)
	damage_timer.start(0.5)


func _on_hurtbox_area_exited(hitbox: Hitbox):
	if hitbox == null:
		return
	
	area_hitbox = null
	damage_timer.stop()
	damage_timer.timeout.disconnect(_on_area_damage)

func _on_area_damage():
	health_component.damage(area_hitbox.damage)
