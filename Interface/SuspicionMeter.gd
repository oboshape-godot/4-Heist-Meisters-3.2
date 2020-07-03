extends TextureProgress

export var suspicion_multiplier : int = 4


func _ready() -> void:
	value = 0

func _process(_delta: float) -> void:
	value -= step


func player_seen() -> void:
	value += step * suspicion_multiplier
	if value >= max_value:
		if get_tree().change_scene("res://Scenes/Levels/LoseScreen.tscn") !=OK :
			print("error changing scene in suspicion script")


func end_game() -> void:
	get_tree().quit()
