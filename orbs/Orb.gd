@export var orb_texture: Texture2D
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if orb_texture:              # only overwrite if provided
		sprite.texture = orb_texture
