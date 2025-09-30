extends Sprite2D

#this is just so i can use the selfmodulate property to change the color of each enemy without manualy recoloring them

@export var image: Texture2D

func _ready() -> void:
	self.texture = image
