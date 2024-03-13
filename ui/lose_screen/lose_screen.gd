class_name LoseScreen
extends Control

@onready var wave_count = $CanvasLayer/MarginContainer/VBoxContainer/WaveCount

func _ready():
	set_process(false)
	var waves_defeated = SpawningManager.waves_spawned - 1 if SpawningManager.waves_spawned >= 1 else 0
	wave_count.text = 'Waves Defeated: %s' % [waves_defeated]

func _on_try_again_pressed():
	GameManager.stop_game()
	SpawningManager.spawn_points.clear()
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free()

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://levels/main_menu/main_menu.tscn")
	GameManager.stop_game()
	SpawningManager.spawn_points.clear()
	get_tree().paused = false
	queue_free()
