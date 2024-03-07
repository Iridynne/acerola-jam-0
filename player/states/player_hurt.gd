class_name PlayerHurt
extends State

@export var sprite: AnimatedSprite2D

func enter():
	print("Player entered state: " + name.to_lower())
	sprite.animation_finished.connect(on_animation_finished)
	sprite.play("hurt")
	pass

func on_animation_finished():
	sprite.animation_finished.disconnect(on_animation_finished)
	
	transitioned.emit(self, "idle")
