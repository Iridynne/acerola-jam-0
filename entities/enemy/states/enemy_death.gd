class_name EnemyDeath
extends State

@onready var hurt_sfx := preload("res://entities/enemy/sounds/enemy_hurt.wav")

@export var enemy: Enemy
@export var sprite: AnimatedSprite2D
@export var audio_player: AudioStreamPlayer
@export var death_timer: Timer

func enter():
	enemy.velocity = Vector2.ZERO
	
	sprite.animation_finished.connect(_on_animation_finished)
	sprite.play("hurt")
	
	# Play hurt sound
	var new_audio_player = audio_player.duplicate()
	new_audio_player.stream = hurt_sfx
	new_audio_player.pitch_scale += randf_range(-0.1, 0.1)
	get_tree().root.add_child(new_audio_player)
	new_audio_player.play()
	await new_audio_player.finished
	new_audio_player.queue_free()
	

func _on_animation_finished():
	sprite.animation_finished.disconnect(_on_animation_finished)
	
	death_timer.start(1)
	await death_timer.timeout
	
	enemy.queue_free()
