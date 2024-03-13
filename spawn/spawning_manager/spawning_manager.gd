extends Node

@onready var spawn_timer := $SpawnTimer

@export var spawn_delay := 1

var spawn_points: Array[SpawnPoint]

var batch_size: int
var spawned_in_total: int
var total_to_spawn: int

var is_spawning := false
var waves_spawned

signal spawned_batch
signal finished_spawning

func start_spawning(to_spawn_at_once: int, to_spawn_total: int = 0):
	if !spawn_points:
		print('No spawn points')
		return
	
	waves_spawned = 0
	batch_size = to_spawn_at_once
	total_to_spawn = to_spawn_total
	is_spawning = true

func stop_spawning():
	finished_spawning.emit()
	is_spawning = false

func _physics_process(delta):
	var enemies_alive = get_tree().get_nodes_in_group("enemy")
	if enemies_alive.size() == 0 && is_spawning:
		await _spawn_batch()

func _spawn_batch():
	var enemies_to_spawn
	
	if total_to_spawn <= 0:
		enemies_to_spawn = batch_size
	else:
		enemies_to_spawn = minf(batch_size, total_to_spawn - spawned_in_total)
	
	if enemies_to_spawn == 0:
		print("Finished spawning")
		is_spawning = false
		finished_spawning.emit()
		return
	
	for index in range(0, batch_size):
		if !is_spawning:
			return
		
		var random_spawnpoint = spawn_points.pick_random()
		random_spawnpoint.spawn()
		spawn_timer.start(spawn_delay)
		await spawn_timer.timeout
	
	print('Spawned %s enemies' % [enemies_to_spawn])
	spawned_in_total += enemies_to_spawn
	batch_size += 1
	waves_spawned += 1
	spawned_batch.emit()
