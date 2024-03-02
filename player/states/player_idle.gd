class_name PlayerIdle
extends State

func enter():
	print("Entered state: " + name.to_lower())
	pass

func update(_delta: float):
	if Input.get_vector("move_left", "move_right", "move_up", "move_down"):
		transitioned.emit(self, "move")
