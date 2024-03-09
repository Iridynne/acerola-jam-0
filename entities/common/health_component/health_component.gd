class_name HealthComponent
extends Node

signal died
signal damaged

@export var max_health := 100
var health: int

var is_alive := true

func _ready():
	health = max_health

func damage(value: int):
	if !is_alive:
		return
	
	health -= value
	
	if health <= 0:
		died.emit()
		is_alive = false
	else:
		damaged.emit(value)
