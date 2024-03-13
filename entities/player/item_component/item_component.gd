class_name ItemComponent
extends Node2D

@onready var item_slot := $ItemSlot
@onready var speech_sound = preload("res://entities/common/sounds/speech.wav")

signal item_equipped
signal item_unequipped

var item: Item

const lines: Array[String] = [
	"I can't equip that!"
]

var is_first_item = true
var first_item_lines: Array[String] = [
	"[Left Click to use item]"
]

func equip(item_to_equip: Item):
	if item:
		DialogueManager.start_dialog(get_parent().global_position, lines, speech_sound)
		await DialogueManager.dialogue_finished
	else:
		item = item_to_equip.duplicate()
		item_slot.add_child(item)
		item_to_equip.get_parent().queue_free()
		
		if is_first_item:
			DialogueManager.start_dialog(global_position, first_item_lines, speech_sound)
			await DialogueManager.dialogue_finished
			InteractionManager.can_interact = false # fix for await
			is_first_item = false
		
		item_equipped.emit()

func unequip():
	if item:
		item_slot.remove_child(item)
		item_unequipped.emit()

func use_item():
	if item:
		item.use.call()
