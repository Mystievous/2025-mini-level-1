extends Control

@export var level_scene: PackedScene

func start_game():
	get_tree().change_scene_to_packed(level_scene)
