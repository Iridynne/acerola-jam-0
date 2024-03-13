class_name VictoryScreen
extends Control

func _ready():
	set_process(false)

func _on_play_again_pressed():
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
