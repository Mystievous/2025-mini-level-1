extends Area2D

@onready var shape: Shape2D = $CollisionShape2D.shape

@export_group("Attack")
@export var attack_color: Statics.ColorType

## The time after attacking before the enemy can attack again 
@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var attack_cooldown: float = 0.75

## The time that the enemy "warns" about attacks before actually attacking
@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var attack_warning_time: float = 0.75

## Multiplier for how far the enemy will "pull back" when warning an attack
@export var warning_distance_multiplier: float = 8.0

@export var effect_scene: PackedScene

@export_group("Node References")
@export var enemySprite: Node2D
@export var enemyBehavior: EnemyBehavior

@onready var cooldown_timer: Timer = Timer.new()
@onready var warning_timer: Timer = Timer.new()

var attack_tween: Tween

var attack_direction: Vector2
var initial_sprite_position: Vector2

var is_on_cooldown: bool:
	get():
		return not cooldown_timer.is_stopped()
		
var is_warning: bool:
	get():
		return not warning_timer.is_stopped()
		
var attack_range: float:
	get():
		if shape is CircleShape2D:
			return shape.radius
		push_warning("enemy_attack collision shape must be a circle")
		return 0.0

func _ready() -> void:
	initial_sprite_position = enemySprite.position
	
	cooldown_timer.one_shot = true
	cooldown_timer.wait_time = attack_cooldown
	add_child(cooldown_timer)
	
	warning_timer.one_shot = true
	warning_timer.wait_time = attack_warning_time
	add_child(warning_timer)
	warning_timer.timeout.connect(_attack)

func _process(_delta: float) -> void:
	if not is_on_cooldown and not is_warning:
		var bodies := get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("Player"):
				var player_position := body.global_position
	
				var vector_towards_player: Vector2 = get_parent().global_position.direction_to(player_position)
				
				# Start warning for an attack towards the current player position
				attack_direction = vector_towards_player
				enemyBehavior.disable_movement = true
				warning_timer.start()
				
	if is_warning:
		enemySprite.position = initial_sprite_position + -(attack_direction * (warning_timer.wait_time - warning_timer.time_left) * warning_distance_multiplier)

func _attack():
	if attack_tween:
		attack_tween.kill()
	attack_tween = create_tween()
	attack_tween.tween_property(enemySprite, "position", initial_sprite_position, 0.05)
	
	
	if effect_scene:
		var slash_position := global_position + (attack_direction * attack_range) * 0.85
		var effect: Node2D = effect_scene.instantiate()
		get_tree().root.add_child(effect)
		effect.global_position = slash_position
		effect.rotate(attack_direction.angle())
		
	var target_position := global_position + (attack_direction * attack_range)
	
	var space_state := get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query := PhysicsRayQueryParameters2D.create(global_position, target_position)
	query.collision_mask = collision_mask
	query.exclude = [self]
	query.collide_with_areas = true
	query.collide_with_bodies = false
	var result := space_state.intersect_ray(query)
	
	if result and result.collider:
		if result.collider.has_method("hurt"):
			result.collider.hurt(attack_color)
	
	enemyBehavior.disable_movement = false
	cooldown_timer.start()
	pass
