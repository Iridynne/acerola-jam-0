extends Item

@onready var light_cone := $LightCone
@onready var hitbox := $Hitbox
@onready var audio_player := $AudioStreamPlayer
@onready var use_sfx := preload("res://items/flashlight/sounds/click.wav")

var is_on := false

func _ready():
	audio_player.stream = use_sfx
	use = Callable(self, "_on_use")

func _on_use():
	is_on = !is_on
	light_cone.visible = is_on
	hitbox.collision_shape.disabled = !is_on
	
	# Play use sound
	var new_audio_player = audio_player.duplicate()
	new_audio_player.pitch_scale += randf_range(-0.1, 0.1)
	get_tree().root.add_child(new_audio_player)
	new_audio_player.play()
	await new_audio_player.finished
	new_audio_player.queue_free()
