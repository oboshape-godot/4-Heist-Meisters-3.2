extends Node2D

var can_click = false

var combination = []
export var combination_length = 4
export var lock_group = "unset"

signal combination


func _ready() -> void:
	generateCombination()
	emit_signal("combination", combination, lock_group)
	$Label.rect_rotation = -global_rotation_degrees
	$Label.text = lock_group
	

func generateCombination():
	combination = CombinationGenerator.generate_combination(combination_length)
	set_popup_text()

func set_popup_text():
	$CanvasLayer/ComputerPopup.set_text(combination)


func _on_Area2D_body_entered(_body: Node) -> void:
	can_click = true


func _on_Area2D_body_exited(_body: Node) -> void:
	can_click = false
	$CanvasLayer/ComputerPopup.hide()
	$Light2D.enabled = false


func _on_ClickableArea_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/ComputerPopup.popup_centered()
		$Light2D.enabled = true
