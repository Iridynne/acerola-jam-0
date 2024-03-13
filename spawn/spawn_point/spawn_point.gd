class_name SpawnPoint
extends Node2D

@export var enemy_scene = preload("res://entities/enemy/enemy.tscn")

func _ready():
	SpawningManager.spawn_points.push_back(self)

func spawn():
	var new_scene = enemy_scene.instantiate()
	new_scene.global_position = global_position
	get_tree().root.add_child(new_scene)
