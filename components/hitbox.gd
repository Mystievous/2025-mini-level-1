extends Area2D
class_name Hitbox

@export_group("Color")
# This makes the `use_color` be a toggle for the `Color` export group
## Whether to filter the incoming attacks by attack color
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var use_color: bool = true
## The color that this hitbox will receive damage from
@export var color: Statics.ColorType

signal killed

func hurt(attack_color: Statics.ColorType):
	if not use_color or attack_color == color: 
		get_parent().queue_free()
		killed.emit()
