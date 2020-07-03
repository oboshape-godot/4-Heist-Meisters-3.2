extends ColorRect



func _on_Area2D_body_entered(_body):
	if _body.has_node("Briefcase"):
		get_tree().change_scene("res://Scenes/Levels/WinScreen.tscn")
