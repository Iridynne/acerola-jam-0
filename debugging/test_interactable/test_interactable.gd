extends Node2D

@onready var interaction_area := $InteractionArea
@onready var speech_sound = preload("res://entities/common/sounds/speech.wav")

const lines: Array[String] = [
	"Hey!",
	"This is a dialogue and interaction test!",
	"Bye!"
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	DialogueManager.start_dialog(global_position, lines, speech_sound)
	await DialogueManager.dialogue_finished
