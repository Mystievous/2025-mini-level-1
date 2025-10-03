extends Node2D

@onready var spawner = get_tree().current_scene.get_node("WaveSpawner")

func _process(_delta):
	if spawner:
		if spawner.is_level_cleared():
			get_tree().change_scene("res://scenes/WinAndLose/Win/WinScreen.tscn")
		else:
			print("Error: WaveSpawner node not found!")
