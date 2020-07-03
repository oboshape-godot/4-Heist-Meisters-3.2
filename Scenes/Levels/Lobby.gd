extends Control



func _on_StartButton_pressed():
	if get_tree().change_scene("res://Scenes/Levels/Level1.tscn") != OK:
		print ("error changing scene on Lobby")


func _on_QuitButton_pressed():
	get_tree().quit()

