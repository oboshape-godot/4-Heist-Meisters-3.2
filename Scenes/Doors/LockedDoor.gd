extends "res://Scenes/Doors/Door.gd"

func _ready():
	generate_combination()


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


func generate_combination():
	var _length = 4
	var _combination = CombinationGenerator.generate_combination(_length)
	$CanvasLayer/NumPad.combination = _combination
	print(_combination)
