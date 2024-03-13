class_name MainLevel
extends Node2D

@onready var player := $Player

@onready var audio_player := $AudioStreamPlayer
@onready var animation_player := $AnimationPlayer
@onready var temp_collider := $TempCollider

@onready var crash_sfx = preload("res://entities/enemy/sounds/crash.wav")

var dialogue1: Array[String] = [
	"*sigh* Another boring day on the job...",
	"I wish something would happen during my shift..."
]

var dialogue2: Array[String] = [
	"!!!",
	"What was that?",
	"I should probably grab my flashlight and go check..."
]

func _ready():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.queue_free()
	
	opening_cutscene()

func opening_cutscene():
	InteractionManager.can_interact = false
	player.is_controllable = false
	
	animation_player.play("fade_in")
	await animation_player.animation_finished
	
	DialogueManager.start_dialog(player.global_position, dialogue1)
	await DialogueManager.dialogue_finished
	
	audio_player.stream = crash_sfx
	audio_player.play()
	await audio_player.finished
	
	DialogueManager.start_dialog(player.global_position, dialogue2)
	await DialogueManager.dialogue_finished
	
	InteractionManager.can_interact = true
	player.is_controllable = true
	
	player.item_component.item_equipped.connect(_on_item_equip)

func _on_item_equip():
	temp_collider.get_node("CollisionPolygon2D").disabled = true
	GameManager.start_game()
