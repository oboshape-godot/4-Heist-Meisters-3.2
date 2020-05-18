extends Area2D

var _canClick : bool

func _on_Door_body_entered(_body):
	if _body.collision_layer == 1:
		_canClick = true
	else:
		open()


func _on_Door_body_exited(_body):
	if _body.collision_layer == 1:
		_canClick = false


func _on_Door_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and _canClick:
		open()


func open():
	$AnimationPlayer.play("OpenClose")
