extends Node2D

onready var anim : AnimationPlayer = $CameraBody/AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var randomAminTime = rand_range(0,anim.current_animation_length)
	anim.advance(randomAminTime)

