extends CharacterBody2D

@onready var ui = get_parent().get_node("UiOverlay")

func _physics_process(_delta: float) -> void:
	var move_vector = Input.get_vector("left", "right", "up", "down")
	
	velocity = move_vector * Statics.base_move_speed
	
	move_and_slide()

func change_color_ui(color:int):
	if (color == Statics.ColorType.RED):
		ui.color_update_ui(Statics.ColorType.RED)
	elif (color == Statics.ColorType.BLUE):
		ui.color_update_ui(Statics.ColorType.BLUE)
	elif (color == Statics.ColorType.GREEN):
		ui.color_update_ui(Statics.ColorType.GREEN)
