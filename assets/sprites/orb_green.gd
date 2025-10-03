extends Area2D

const color = Statics.ColorType.GREEN

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body: Node2D):
	if (body.has_method("change_color_ui")):
		body.change_color_ui(color)
