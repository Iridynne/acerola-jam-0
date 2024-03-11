extends Node

@onready var timer := $Timer

@onready var pause_menu_scene = preload("res://ui/pause_menu/pause_menu.tscn")

@export_group("Shift duration")
# Shift hours
@export_range(0, 23) var shift_start_hour := 0
@export_range(0, 59) var shift_start_minutes := 0
@export_range(0, 23) var shift_end_hour := 6
@export_range(0, 59) var shift_end_minutes := 0

# Minute duration in seconds
@export var minute_duration := 0.5

var is_game_in_progress := false

var current_time_hour
var current_time_minutes

signal time_updated
signal shift_ended

# Pause menu
var pause_menu

func _ready():
	current_time_hour = shift_start_hour
	current_time_minutes = shift_start_minutes
	
	timer.start(2)
	await timer.timeout
	
	start_game()

func start_game():
	shift_ended.connect(_on_shift_ended)
	SpawningManager.start_spawning(2)
	
	is_game_in_progress = true
	timer.timeout.connect(_update_time)
	timer.start(minute_duration)

func _update_time():
	current_time_minutes += 1
	if current_time_minutes >= 60:
		current_time_hour += 1
		current_time_minutes %= 60
	
	if current_time_hour < shift_end_hour or (current_time_hour == shift_end_hour and current_time_minutes < shift_end_minutes):
		time_updated.emit(current_time_hour, current_time_minutes)
		timer.start(minute_duration)
		return
	else:
		time_updated.emit(current_time_hour, current_time_minutes)
		shift_ended.emit()

func _on_shift_ended():
	print('Shift ended!')

func _input(event):
	if event.is_action_pressed("pause") and get_tree().current_scene.name != "MainMenu":
		if !get_tree().paused:
			pause_menu = pause_menu_scene.instantiate()
			pause_menu.set_process(true)
			pause_menu.unpaused.connect(_on_unpause)
			get_tree().root.add_child(pause_menu)
			get_tree().paused = true

func _on_unpause():
	pause_menu.queue_free()
	get_tree().paused = false
