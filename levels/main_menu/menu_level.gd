extends Control

@onready var main_menu := $Main
@onready var options_menu := $Options

func show_main():
	options_menu.hide()
	main_menu.show()

func show_options():
	main_menu.hide()
	options_menu.show()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://levels/main_level.tscn")

func _on_options_pressed():
	show_options()

func _on_quit_pressed():
	get_tree().quit()
