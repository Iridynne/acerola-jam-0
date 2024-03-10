@tool
extends Camera2D

@onready var effects = $Effects
@onready var background = $Background

@onready var vhs_shader_material = $Effects/VHS/ColorRect.material

@export var roll: bool:
	set(value):
		if vhs_shader_material:
			vhs_shader_material.set_shader_parameter('roll', value)
	get:
		return vhs_shader_material.get_shader_parameter('roll')

@export var abberation: float:
	set(value):
		if vhs_shader_material:
			vhs_shader_material.set_shader_parameter('aberration', value)
	get:
		return vhs_shader_material.get_shader_parameter('aberration')

@export var brightness: float:
	set(value):
		if vhs_shader_material:
			vhs_shader_material.set_shader_parameter('brightness', value)
	get:
		return vhs_shader_material.get_shader_parameter('brightness')

func _ready():
	if Engine.is_editor_hint():
		background.hide()
		
		var canvas_layers = effects.get_children()
		for layer in canvas_layers:
			layer.hide()
