extends Camera2D

var player: Node2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if not player:
		push_warning("Player node could not be found!")

func get_target_pos():
	if player:
		return player.global_position

func refresh_pos() -> void:
	var target_pos = get_target_pos()
	if target_pos:
		global_position = target_pos

func _physics_process(_delta: float) -> void:
	refresh_pos()
