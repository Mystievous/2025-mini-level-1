extends CharacterBody2D

const SPEED = 300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	var vert_direction := Input.get_axis("move_up", "move_down")
	
	# flip sprite 
	if direction == 1: 
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true
	
	# flip sprite vertically 
	
#	vertical movement 
	if vert_direction:
		velocity.y = vert_direction * SPEED
	else: 
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
#	horizontal movement
	if direction:
		velocity.x = direction * SPEED
		
	else: # direction is 0 
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
