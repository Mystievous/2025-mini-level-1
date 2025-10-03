extends CharacterBody2D

const SPEED := 300.0

@onready var sprite: Sprite2D = $Sprite2D

@export var skin_red: Texture2D
@export var skin_green: Texture2D
@export var skin_blue: Texture2D
	
func set_color(color_id: String) -> void:
	match color_id:
		"red":
			sprite.texture = skin_red
		"green":
			sprite.texture = skin_green
		"blue":
			sprite.texture = skin_blue
		_:
			push_warning("Unknown color_id: %s" % color_id)

func _physics_process(delta: float) -> void:
	var dir_x := Input.get_axis("move_left", "move_right")
	var dir_y := Input.get_axis("move_up", "move_down")

	velocity.x = dir_x * SPEED
	velocity.y = dir_y * SPEED

	if dir_x == 1:
		sprite.flip_h = false
	elif dir_x == -1:
		sprite.flip_h = true

	move_and_slide()
