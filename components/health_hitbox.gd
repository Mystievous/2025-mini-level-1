extends Area2D
class_name HealthHitbox

signal health_changed(new_value: int)

# This will be populated automatically from the `CharacterStats` resource on the main entity.
@export var max_health: int = 20

var current_health: int = max_health:
	get():
		return current_health
	set(value):
		current_health = max(0, min(max_health, value)) # Constrain to ">= 0" and "<= max_health"
		health_changed.emit(value)
		get_parent().queue_free()

func damage(value: int):
	current_health -= value

func heal(value: int):
	current_health += value
