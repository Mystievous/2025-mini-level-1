extends Node2D

@onready var parent: CharacterBody2D = get_parent()

@export var animated_sprite: AnimatedSprite2D
@export var pause_when_idle: bool = true

@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var animation_debounce_time: float = 0.05

var debounce_timer: Timer

var target_animation: String

func _ready() -> void:
	debounce_timer = Timer.new()
	debounce_timer.wait_time = animation_debounce_time
	debounce_timer.timeout.connect(_apply_animation)
	add_child(debounce_timer)
	
	animated_sprite.play()

func _physics_process(_delta: float) -> void:
	_check_animation()


func _check_animation() -> void:	
	var move_angle := parent.velocity.angle()

	if parent.velocity.is_zero_approx():
		if pause_when_idle:
			animated_sprite.stop()
		return
	
	var directions := {
		"walk_right": absf(angle_difference(move_angle, Vector2.RIGHT.angle())),
		"walk_up": abs(angle_difference(move_angle, Vector2.UP.angle())),
		"walk_left": abs(angle_difference(move_angle, Vector2.LEFT.angle())),
		"walk_down": abs(angle_difference(move_angle, Vector2.DOWN.angle()))
	}
	
	var closest_angle_animation: String
	var closest_angle_value: float
	
	for key in directions:
		if not closest_angle_animation:
			closest_angle_animation = key
			closest_angle_value = directions[key]
			continue
		
		if directions[key] < closest_angle_value:
			closest_angle_animation = key
			closest_angle_value = directions[key]
			
	if target_animation != closest_angle_animation:
		target_animation = closest_angle_animation
		debounce_timer.start()
		
	if not animated_sprite.is_playing():
		animated_sprite.play()
	
func _apply_animation() -> void:
	animated_sprite.animation = target_animation
