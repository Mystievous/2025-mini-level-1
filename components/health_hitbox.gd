extends Area2D
class_name HealthHitbox

signal killed

func hurt():
	killed.emit()
