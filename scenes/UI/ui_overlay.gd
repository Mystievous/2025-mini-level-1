extends CanvasLayer
class_name PlayerUI

@onready var color_label = $CharacterColor
@onready var controlPanelBG = $ControlsBackground
@onready var ProgBackground = $ProgressBackground
@onready var wave_progress_label: RichTextLabel = $ProgressLabel
@onready var wave_label: RichTextLabel = $WaveLabel  # adjust the path
@onready var spawner: WaveSpawner = get_tree().current_scene.get_node("Spawner")

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

func _ready():
	if spawner:
		spawner.connect("wave_started", Callable(self, "_on_wave_started"))
		wave_label.text = "[font_size=15][center]Wave " + str(spawner.currentWave) + "[/center][/font_size]"
		
func _on_wave_started(wave_num: int):
	wave_label.text = "[font_size=25][center]Wave " + str(wave_num) + "[/center][/font_size]"

func _process(_delta):
	if spawner:
		var progress = spawner.get_wave_progress() * 100  # 0 → 100%
		wave_progress_label.text = "[font_size=15]Progress: " + str(round(progress)) + "%[/font_size]"
