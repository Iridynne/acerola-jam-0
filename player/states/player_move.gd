class_name PlayerMove
extends State

@export var player: Player

func enter():
	print("Entered state: " + name.to_lower())
	pass

func update(_delta: float):
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") == Vector2.ZERO:
		transitioned.emit(self, "idle")

func physics_update(delta: float):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player.velocity = direction * player.speed

func exit():
	player.velocity = Vector2.ZERO
