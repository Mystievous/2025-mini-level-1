extends NavigationAgent2D
class_name EnemyBehavior

@export_group("Wandering")
## The area the enemy will see the player inside, otherwise the enemy will wander
@export var player_detection_area: Area2D
## Minimum time the enemy might sit idle before wandering
@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var minimum_idle_time: float = 2.5
## Maximum time the enemy might sit idle before wandering
@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var maximum_idle_time: float = 5.0
## Minimum distance the enemy can wander
@export var minimum_wander_distance: float = 10.0
## Maximum distance the enemy can wander
@export var maximum_wander_distance: float = 40.0

@export_group("Tracking Player")
## The distance that this enemy will try to stay at from the player while tracking.
@export_custom(PROPERTY_HINT_NONE, "suffix:px") var target_distance_from_player: float = 30.0

## The speed (multiplied by `Statics.base_move_speed / 2`) that the enemy will move.
@export_range(0, 2, 0.05, "or_greater") var speed_multiplier: float = 1.0

var disable_movement: bool = false

var move_speed: 
	get():
		return Statics.base_move_speed * speed_multiplier / 2

var parent: CharacterBody2D

var player: Node2D

var idle_timer: Timer
var wander_target: Vector2 = Vector2.ZERO

func _ready() -> void:
	idle_timer = Timer.new()
	idle_timer.timeout.connect(wander)
	add_child(idle_timer)
	
	var parentNode = get_parent()
	parent = parentNode
		
	velocity_computed.connect(_on_velocity_computed)
	
	player_detection_area.body_entered.connect(_on_detection_body_entered)
	player_detection_area.body_exited.connect(_on_detection_body_exited)

func _on_detection_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		player = body
		idle_timer.stop()

func _on_detection_body_exited(body: Node2D):
	if body == player:
		player = null

func wander() -> void:
	var vector := Vector2.from_angle(randf() * 2 * PI).normalized()
	
	var distance := randf_range(minimum_wander_distance, maximum_wander_distance)
	
	wander_target = parent.global_position + vector * distance
	print("Wandering to ", wander_target)
	
func clear_wander() -> void:
	idle_timer.stop()
	wander_target = Vector2.ZERO

func _get_target_position_by_player() -> Vector2:
	if not player:
		return Vector2.ZERO
	
	var player_position = player.global_position
	
	var vector_player_towards_self = Vector2.from_angle(player_position.angle_to_point(parent.global_position)).normalized() * target_distance_from_player
	
	return player_position + vector_player_towards_self

func _physics_process(_delta: float) -> void:
	if disable_movement:
		velocity = Vector2()
		return
	if not player and idle_timer.is_stopped() and not wander_target:
		idle_timer.wait_time = randf_range(minimum_idle_time, maximum_idle_time)
		idle_timer.start()
			
		return
		
	if wander_target:
		target_position = wander_target
	else:
		target_position = _get_target_position_by_player()
	
	if not target_position:
		return
	
	var current_agent_position = parent.global_position
	var next_path_position = get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * move_speed
	
	if is_navigation_finished():
		if wander_target:
			wander_target = Vector2.ZERO
		return
	
	if avoidance_enabled:
		velocity = new_velocity
	else:
		_on_velocity_computed(new_velocity)
		
	parent.move_and_slide()

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	if parent:
		parent.velocity = safe_velocity
