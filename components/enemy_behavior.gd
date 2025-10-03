extends NavigationAgent2D
class_name EnemyBehavior

## The distance that this enemy will try to stay at from the player.
@export_custom(PROPERTY_HINT_NONE, "suffix:px") var target_distance_from_player: float = 30.0

## The speed (multiplied by `Statics.base_move_speed / 2`) that the enemy will move.
@export_range(0, 2, 0.05, "or_greater") var speed_multiplier: float = 1.0

var disable_movement: bool = false

var move_speed: 
	get():
		return Statics.base_move_speed * speed_multiplier / 2

var parent: CharacterBody2D

var player: Node2D

func _ready() -> void:
	var parentNode = get_parent()
	if parentNode is CharacterBody2D:
		parent = parentNode
	else:
		push_error("EnemyBehavior is meant to be a direct child of a CharacterBody2D.")
		
	var playerNode = get_tree().get_first_node_in_group("Player")
	if playerNode:
		player = playerNode
	else:
		push_warning("Player node could not be found!")
		
	velocity_computed.connect(_on_velocity_computed)

func _get_target_position_by_player():
	if not player:
		return
	
	var player_position = player.global_position
	
	var vector_player_towards_self = Vector2.from_angle(player_position.angle_to_point(parent.global_position)).normalized() * target_distance_from_player
	
	return player_position + vector_player_towards_self

func _physics_process(_delta: float) -> void:
	if disable_movement:
		velocity = Vector2()
		parent.move_and_slide()
		return
	if not player:
		return
		
	target_position = _get_target_position_by_player()
	
	var current_agent_position = parent.global_position
	var next_path_position = get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * move_speed
	
	if is_navigation_finished():
		return
	
	if avoidance_enabled:
		velocity = new_velocity
	else:
		_on_velocity_computed(new_velocity)
		
	parent.move_and_slide()

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	if parent:
		parent.velocity = safe_velocity
