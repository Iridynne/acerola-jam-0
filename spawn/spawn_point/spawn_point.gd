class_name SpawnPoint
extends Node2D

@export var scene_to_spawn: PackedScene

func _ready():
	SpawningManager.spawn_points.push_back(self)

func spawn():
	var new_scene = scene_to_spawn.instantiate()
	new_scene.global_position = global_position
	get_tree().root.add_child(new_scene)
