extends Node2D

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_up: RayCast2D = $RayCastUp

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var animation_timer: Timer = $AnimationTimer
@onready var jester: CharacterBody2D = $"../../Jester"
@onready var hitbox: Hitbox = $Hitbox



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
	

#i really need to refactor these to just one 
#handle attack, with parameters 	

func handle_right_attack(direction):
	if direction == 0 or direction == 1:
		if Input.is_action_just_pressed("attack"):
			print("animation played")
			#animated_sprite_2d.stop()
			#animated_sprite_2d.play("Attack")
			#animation_timer.start()
			if ray_cast_right.is_colliding(): 
				#hit.emit()
				var area := ray_cast_right.get_collider()
				if area is Hitbox:
					hurt_all_enemies(area)
				print("hit with right attack")
				
func handle_left_attack(direction):
	if direction == 0 or direction == -1:
		if Input.is_action_just_pressed("attack"):
			if ray_cast_left.is_colliding(): 
				var area := ray_cast_left.get_collider()
				if area is Hitbox:
					hurt_all_enemies(area)
				print("hit with left attack")
				hit.emit()
			
func handle_down_attack(direction):
	if direction == 0 or direction == -1:
		if Input.is_action_just_pressed("attack"):
			#animated_sprite_2d.play("Attack")
			if ray_cast_down.is_colliding(): 
				var area := ray_cast_down.get_collider()
				if area is Hitbox:
					hurt_all_enemies(area)
				print("hit with down attack")
				hit.emit()
				
func handle_up_attack(direction):
	if direction == 0 or direction == 1:
		if Input.is_action_just_pressed("attack"):
			#animated_sprite_2d.play("Attack")
			if ray_cast_up.is_colliding(): 
				var area := ray_cast_up.get_collider()
				if area is Hitbox:
					hurt_all_enemies(area)
				print("hit with up attack")
				hit.emit()
				
func hurt_all_enemies(area):
	area.hurt(Statics.ColorType.RED)
	area.hurt(Statics.ColorType.BLUE)
	area.hurt(Statics.ColorType.GREEN)

func _on_animation_timer_timeout() -> void:
	animated_sprite_2d.stop()
