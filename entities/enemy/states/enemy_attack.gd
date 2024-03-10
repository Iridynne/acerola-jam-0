class_name EnemyAttack
extends State

@export var sprite: AnimatedSprite2D
@export var hitbox: Hitbox

func enter():
	sprite.animation_finished.connect(_on_animation_finished)
	sprite.play("attack")
	hitbox.collision_shape.disabled = false
	pass

func exit():
	sprite.animation_finished.disconnect(_on_animation_finished)
	hitbox.collision_shape.disabled = true

func _on_animation_finished():
	hitbox.collision_shape.disabled = true
	transitioned.emit(self, "idle")
