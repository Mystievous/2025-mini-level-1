extends Area2D

@onready var timer: Timer = $Timer

## The color the orb gives the player
@export var color_id: String = "red"

func _init() -> void:
	#Connecting signal on this Area2D to the _on_body_entered() function
	body_entered.connect(_on_body_entered)

func _on_body_entered(body : Node) -> void:
	if not timer.is_stopped():
		return
	if not body.is_in_group("player"): 
		return 

	#tells the player to change its color/sprite
	if body.has_method("set_color"):
		body.set_color(color_id)
		timer.start()
