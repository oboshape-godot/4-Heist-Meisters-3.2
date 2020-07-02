extends "res://Scenes/Doors/Door.gd"

func _ready():
	$Label.rect_rotation = -global_rotation_degrees


func _on_Door_input_event(_viewport, _event, _shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and _canClick:
		$CanvasLayer/NumPad.popup_centered()


func _on_Door_body_exited(_body):
	if _body.collision_layer == 1:
		_canClick = false
		$CanvasLayer/NumPad.hide()


func _on_NumPad_combination_correct():
	$CanvasLayer/NumPad.hide()
	open()


func _on_Computer_combination(_numbers, lock_group) -> void:
	$Label.text = lock_group
	$CanvasLayer/NumPad.combination = _numbers
