extends Control

@onready var time_label = $CanvasLayer/MarginContainer/Time
@onready var health_bar = $CanvasLayer/MarginContainer/Control/HealthBar

@export var player: Player

var health_component: HealthComponent

func _ready():
	GameManager.time_updated.connect(_on_time_updated)
	
	health_component = player.get_node("HealthComponent")
	
	health_bar.max_value = health_component.max_health
	health_bar.value = health_bar.max_value
	health_component.health_updated.connect(_on_health_update)
	
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

func _on_health_update(health: int):
	health_bar.value = health
	
	if health <= 0.25 * health_bar.max_value:
		health_bar.tint_under = Color('b0305c')
		health_bar.tint_progress = Color('b0305c')
	else:
		health_bar.tint_under = Color('ffffff')
		health_bar.tint_progress = Color('ffffff')
