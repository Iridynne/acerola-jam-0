@tool
extends Camera2D

@onready var effects = $Effects
@onready var background = $Background

@onready var vhs_shader_material = $Effects/VHS/ColorRect.material

func _ready():
	var is_editor = Engine.is_editor_hint()
	
	background.visible = !is_editor
	toggle_effects(!is_editor)

func toggle_effects(value: bool):
	var canvas_layers = effects.get_children()
	for layer in canvas_layers:
		layer.visible = value
