extends RayCast2D

@onready var ray_cast_right: RayCast2D = $"."
@onready var ray_cast_left: RayCast2D = $"../RayCastLeft"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var horizontal_direction := Input.get_axis("move_left", "move_right")
	var vertcal_direction := Input.get_axis("move_up", "move_down")
	
	handle_right_attack(horizontal_direction)
	handle_left_attack(horizontal_direction)
	
func handle_right_attack(direction):
	if direction == 0 or direction == 1:
		if Input.is_action_just_pressed("attack"):
#		play animation here 
			print("animation right attack played")
			if ray_cast_right.is_colliding(): 
				print("hit with right attack")
				
func handle_left_attack(direction):
	if direction == 0 or direction == -1:
		if Input.is_action_just_pressed("attack"):
#		play animation here 
			print("animation left attack played")
			if ray_cast_left.is_colliding(): 
				print("hit with right attack")
			
