class_name MainMenu
extends Control

@onready var main_level = preload("res://levels/main_level/main_level.tscn")
@onready var margin_container = $MarginContainer
@onready var options_menu = $OptionsMenu

@onready var quit_button = $MarginContainer/HBoxContainer/VBoxContainer/Quit

func _ready():
	options_menu.exited_option_menu.connect(_on_exit_options_menu)
	
	# Hide quit button on Web
	if OS.has_feature("web"):
		quit_button.hide()

func _on_play_pressed():
	get_tree().change_scene_to_packed(main_level)

func _on_options_pressed():
	margin_container.hide()
	options_menu.set_process(true)
	options_menu.show()

func _on_quit_pressed():
	get_tree().quit()

func _on_exit_options_menu():
	options_menu.hide()
	margin_container.show()
