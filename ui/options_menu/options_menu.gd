class_name OptionsMenu
extends Control

signal exited_option_menu

func _ready():
	set_process(false)

func _on_back_pressed():
	exited_option_menu.emit()
	set_process(false)
