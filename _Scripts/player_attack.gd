extends RayCast2D

@onready var ray_cast_right: RayCast2D = $"."
@onready var ray_cast_left: RayCast2D = $"../RayCastLeft"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var horizontal_direction := Input.get_axis("move_left", "move_right")
	var vertcal_direction := Input.get_axis("move_up", "move_down")
	
	#var collider_name: String = ray_cast_right.get_collider()
	if horizontal_direction == 0 or horizontal_direction == 1:
		if ray_cast_right.is_colliding(): 
			if Input.is_action_just_pressed("attack"):
				print("hit with right attack")
			#			which body is the raycastright hitting 
			
