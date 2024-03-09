extends Node2D

@onready var interaction_area := $InteractionArea
@onready var player = get_tree().get_first_node_in_group("player")
@onready var flashlight := $Flashlight

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	await player.item_component.equip(flashlight)
	
