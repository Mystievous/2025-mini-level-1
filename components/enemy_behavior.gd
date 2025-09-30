extends Node2D

@onready var navigation_agent_2d: NavigationAgent2D = %NavigationAgent2D

@export var speed_multiplier: int = 1

var move_speed: 
	get():
		return Statics.base_move_speed * speed_multiplier

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
		

func _physics_process(delta: float) -> void:
	if not player:
		return
	var player_position = player.global_position
	navigation_agent_2d.target_position = player_position
	
	var current_agent_position = self.global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * move_speed
	
	if navigation_agent_2d.is_navigation_finished():
		return
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.velocity = new_velocity
	else:
		_on_velocity_computed(new_velocity)
		
	parent.move_and_slide()


func _on_velocity_computed(safe_velocity: Vector2) -> void:
	if parent:
		parent.velocity = safe_velocity
