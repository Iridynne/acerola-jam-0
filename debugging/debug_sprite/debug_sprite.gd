@tool
extends Sprite2D

func _ready():
	if !Engine.is_editor_hint():
		hide()
