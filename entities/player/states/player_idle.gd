class_name PlayerIdle
extends State

@export var player: Player
@export var sprite: AnimatedSprite2D

func enter():
	sprite.play("idle")
	pass

func update(_delta: float):
	if DialogueManager.is_dialog_active || !player.is_controllable:
		return
	
	if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		transitioned.emit(self, "move")
