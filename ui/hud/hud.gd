extends Control

@onready var time_label = $CanvasLayer/MarginContainer/Time

func _ready():
	GameManager.time_updated.connect(_on_time_updated)
	
	_on_time_updated(GameManager.current_time_hour, GameManager.current_time_minutes)

func toggle(value: bool):
	visible = value

func _on_time_updated(hour: int, minutes: int):
	var hour_12 = 12 if hour % 12 == 0 else hour % 12
	var minutes_12 = '0%s' % [minutes] if minutes < 10 else minutes
	var termination = 'AM' if hour < 12 else 'PM'
	
	if hour_12 < 10:
		hour_12 = '0%s' % [hour]
	
	time_label.text = '%s:%s %s' % [hour_12, minutes_12, termination]
