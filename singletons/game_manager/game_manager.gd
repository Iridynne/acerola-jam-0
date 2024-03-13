extends Node

@onready var timer := $Timer
@onready var pause_menu_scene = preload("res://ui/pause_menu/pause_menu.tscn")
@onready var victory_screen_scene = preload("res://ui/victory_screen/victory_screen.tscn")
@onready var lose_screen_scene = preload("res://ui/lose_screen/lose_screen.tscn")

# Shift hours
@export_range(0, 23) var shift_start_hour := 0
@export_range(0, 59) var shift_start_minutes := 0
@export_range(0, 23) var shift_end_hour := 6
@export_range(0, 59) var shift_end_minutes := 0

# Minute duration in seconds
@export var minute_duration := 0.3

var is_game_finished := false

var current_time_hour
var current_time_minutes

signal time_updated
signal shift_ended

var player: Player

var shift_end_lines: Array[String] = [
	"Phew... Seems it's finally over",
	"I think that's enough for this job..."
]

var pause_menu
var victory_screen
var lose_screen

func _ready():
	current_time_hour = shift_start_hour
	current_time_minutes = shift_start_minutes
	
	is_game_finished = false

func start_game():
	is_game_finished = false
	player = get_tree().get_first_node_in_group("player")
	shift_ended.connect(_on_shift_ended)
	
	SpawningManager.start_spawning(3)
	
	timer.timeout.connect(_update_time)
	timer.start(minute_duration)

func stop_game():
	current_time_hour = shift_start_hour
	current_time_minutes = shift_start_minutes
	SpawningManager.stop_spawning()
	timer.stop()

func _update_time():
	current_time_minutes += 1
	if current_time_minutes >= 60:
		current_time_hour += 1
		current_time_minutes %= 60
	
	if current_time_hour < shift_end_hour or (current_time_hour == shift_end_hour and current_time_minutes <= shift_end_minutes):
		time_updated.emit(current_time_hour, current_time_minutes)
		timer.start(minute_duration)
		return
	else:
		shift_ended.emit()

func _on_shift_ended():
	is_game_finished = true
	
	player.velocity = Vector2.ZERO
	player.is_controllable = false
	player.item_component.unequip()
	
	SpawningManager.stop_spawning()
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.health_component.damage(1000)
	
	DialogueManager.start_dialog(player.global_position, shift_end_lines)
	await DialogueManager.dialogue_finished
	
	victory_screen = victory_screen_scene.instantiate()
	victory_screen.set_process(true)
	get_tree().root.add_child(victory_screen)
	get_tree().paused = true

func on_game_over():
	is_game_finished = true
	
	lose_screen = lose_screen_scene.instantiate()
	lose_screen.set_process(true)
	get_tree().root.add_child(lose_screen)
	get_tree().paused = true
	pass

func _input(event):
	if event.is_action_pressed("pause") and get_tree().current_scene.name != "MainMenu" and !is_game_finished:
		if !get_tree().paused:
			pause_menu = pause_menu_scene.instantiate()
			pause_menu.set_process(true)
			pause_menu.unpaused.connect(_on_unpause)
			get_tree().root.add_child(pause_menu)
			get_tree().paused = true

func _on_unpause():
	pause_menu.queue_free()
	get_tree().paused = false
