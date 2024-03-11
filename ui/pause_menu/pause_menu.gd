class_name PauseMenu
extends Control

@onready var main_menu = preload("res://levels/main_menu/main_menu.tscn")

signal unpaused

func _ready():
	set_process(false)

func _on_continue_pressed():
	set_process(false)
	unpaused.emit()

func _on_quit_pressed():
	get_tree().change_scene_to_packed(main_menu)
	get_tree().paused = false
	queue_free()
