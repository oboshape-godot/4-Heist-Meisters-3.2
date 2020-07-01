extends Area2D



func _on_Briefcase_body_entered(_body):
	_body.collect_briefcase()
	queue_free()
