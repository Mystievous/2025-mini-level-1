extends Area2D
class_name Hitbox

signal killed

func hurt():
	get_parent().queue_free()
	killed.emit()
