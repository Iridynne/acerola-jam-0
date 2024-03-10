class_name EnemyHurt
extends State

@onready var hurt_sfx := preload("res://entities/enemy/sounds/enemy_hurt.wav")

@export var sprite: AnimatedSprite2D
@export var audio_player: AudioStreamPlayer

func enter():
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
	
	transitioned.emit(self, "idle")
