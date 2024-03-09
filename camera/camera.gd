@tool
extends Camera2D

@onready var effects = $Effects
@onready var background = $Background

func _ready():
	if Engine.is_editor_hint():
		background.hide()
		
		var canvas_layers = effects.get_children()
		for layer in canvas_layers:
			layer.hide()
