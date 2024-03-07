extends Node2D

@onready var interaction_area := $InteractionArea

const lines: Array[String] = [
	"Hey!",
	"This is a dialogue and interaction test!",
	"Bye!"
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	DialogueManager.start_dialog(global_position, lines)
	await DialogueManager.dialogue_finished
