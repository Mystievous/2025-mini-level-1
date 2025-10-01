extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	var move_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = move_vector * Statics.base_move_speed
	
	move_and_slide()
