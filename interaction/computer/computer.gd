extends Node2D

@onready var interaction_area := $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player")
@onready var speech_sound = preload("res://entities/common/sounds/speech.wav")

const lines: Array[String] = [
	"I'll have time for that later!",
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	DialogueManager.start_dialog(player.global_position, lines, speech_sound)
	await DialogueManager.dialogue_finished
