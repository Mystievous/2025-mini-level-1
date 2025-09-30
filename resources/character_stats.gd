extends Resource
class_name CharacterStats

## The maximum health of the enemy.
@export_range(0, 100, 1, "or_greater") var health: int = 20

## The speed multiplier (vs the player's) that the enemy will move.
@export_range(0, 2, 0.05, "or_greater") var speed_multiplier: float = 1

## The color assigned to the enemy.
@export var color: Statics.ColorType
