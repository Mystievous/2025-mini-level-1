extends CanvasLayer
class_name PlayerUI

@onready var color_label = $CharacterColor
@onready var controlPanelBG = $ControlsBackground
@onready var ProgBackground = $ProgressBackground


func color_update_ui(new_color: Statics.ColorType) -> void:
	match new_color:
		Statics.ColorType.RED:
			controlPanelBG.modulate = Color(256, 0.0, 0.0) # red
			ProgBackground.modulate = Color(256, 0.0, 0.0) # red
			color_label.text = "[font_size=15][center]Red[/center]
[/font_size]"
		Statics.ColorType.GREEN:
			controlPanelBG.modulate = Color(0.0, 256, 0.0) # green
			ProgBackground.modulate = Color(0.0, 256, 0.0) # green
			color_label.text = "[font_size=15][center]Green[/center]
[/font_size]"
		Statics.ColorType.BLUE:
			controlPanelBG.modulate = Color(0.0, 0.0, 256) # blue
			ProgBackground.modulate = Color(0.0, 0.0, 256) # blue
			color_label.text = "[font_size=15][center]Blue[/center]
[/font_size]"
