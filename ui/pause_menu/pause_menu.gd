class_name PauseMenu
extends Control

signal unpaused

func _ready():
	set_process(false)

func _on_continue_pressed():
	set_process(false)
	unpaused.emit()

func _on_quit_pressed():
	var game_scene = get_tree().current_scene
	get_tree().change_scene_to_file("res://levels/main_menu/main_menu.tscn")
	GameManager.stop_game()
	SpawningManager.spawn_points.clear()
	get_tree().paused = false
	get_tree().root.remove_child(game_scene)
	queue_free()
