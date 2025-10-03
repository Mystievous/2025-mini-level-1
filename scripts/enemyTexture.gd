extends Sprite2D

#this is just so i can use the Self Modulate property to change the color of each enemy without manually recoloring them

@export var image: Texture2D

func _ready() -> void:
	self.texture = image
