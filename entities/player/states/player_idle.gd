class_name PlayerIdle
extends State

@export var sprite: AnimatedSprite2D

func enter():
	print("Player entered state: " + name.to_lower())
	sprite.play("idle")
	pass

func update(_delta: float):
	if DialogueManager.is_dialog_active:
		return
	
	if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		transitioned.emit(self, "move")
