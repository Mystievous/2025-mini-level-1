extends Node2D

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_up: RayCast2D = $RayCastUp

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

signal hit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var horizontal_direction := Input.get_axis("move_left", "move_right")
	var vertical_direction := Input.get_axis("move_down", "move_up")
	
	#print(vertical_direction)
	
	handle_right_attack(horizontal_direction)
	handle_left_attack(horizontal_direction)
	handle_down_attack(vertical_direction)
	handle_up_attack(vertical_direction)
	
func handle_right_attack(direction):
	if direction == 0 or direction == 1:
		if Input.is_action_just_pressed("attack"):
			#animated_sprite_2d.play("Attack")
			if ray_cast_right.is_colliding(): 
				hit.emit()
				print("hit with right attack")
				
func handle_left_attack(direction):
	if direction == 0 or direction == -1:
		if Input.is_action_just_pressed("attack"):
			#animated_sprite_2d.play("Attack")
			if ray_cast_left.is_colliding(): 
				print("hit with left attack")
				hit.emit()
			
func handle_down_attack(direction):
	if direction == 0 or direction == -1:
		if Input.is_action_just_pressed("attack"):
			#animated_sprite_2d.play("Attack")
			if ray_cast_down.is_colliding(): 
				print("hit with down attack")
				hit.emit()
				
func handle_up_attack(direction):
	if direction == 0 or direction == 1:
		if Input.is_action_just_pressed("attack"):
			#animated_sprite_2d.play("Attack")
			if ray_cast_up.is_colliding(): 
				print("hit with up attack")
				hit.emit()
