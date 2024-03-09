class_name ItemComponent
extends Node2D

@onready var item_slot := $ItemSlot
@onready var speech_sound = preload("res://entities/common/sounds/speech.wav")

var item: Item

const lines: Array[String] = [
	"I can't equip that!"
]

func equip(item_to_equip: Item):
	if item:
		DialogueManager.start_dialog(get_parent().global_position, lines, speech_sound)
		await DialogueManager.dialogue_finished
	else:
		item = item_to_equip.duplicate()
		item_slot.add_child(item)
		item_to_equip.get_parent().queue_free()

func unequip():
	item_slot.remove_child(item)

func use_item():
	if item:
		item.use.call()
