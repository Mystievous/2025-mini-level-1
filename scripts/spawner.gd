extends Marker2D
#preloads the enemies to be able to insantiate them from the spawner
var enemySceneRed   = preload("res://scenes/enemies/enemyRed.tscn")
var enemySceneGreen = preload("res://scenes/enemies/enemyGreen.tscn")
var enemySceneBlue  = preload("res://scenes/enemies/enemyBlue.tscn")

enum SpawnerTypeEnum {
	RANDOM, ##0, randomly spawn red, green or blue
 	   RED, ##1, spawns red
	 GREEN, ##2, spawns green
	  BLUE  ##3, spawns blue
}

##Determines what monsters will spawn from the Marker2D spawner. Default: Random
@export var spawnerType: SpawnerTypeEnum

##Determines how far enemies can spawn from the Marker2D spawner. Default: 100
@export var spawnRadiusSize: int = 100 

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"): #spawns a new enemy when spacebar is pressed
		spawnEnemy()

func spawnEnemy() -> void:
	var enemyInstance
	var spawnerTypeSelection
	
	if spawnerType == SpawnerTypeEnum.RANDOM:
		spawnerTypeSelection = randi_range(1, 3) #if Spawner Type is set to random, it will set spawnerTypeSelection to a random int between 1 and 3 inclusive
	else:
		spawnerTypeSelection = spawnerType #if Spawner Type is NOT set to random, it will set spawnerTypeSelection to the selected value
	
	match spawnerTypeSelection: #uses the int value in spawnerTypeSelection to determine which monster to instantiate 
		1: enemyInstance = enemySceneRed.instantiate()
		2: enemyInstance = enemySceneGreen.instantiate()
		3: enemyInstance = enemySceneBlue.instantiate()
		_:
			#print("Default case in spawner match statement")
			enemyInstance = enemySceneRed.instantiate()
	add_child(enemyInstance) #adds the new enemy to the scene

	#modifies the enemies position to a random range determined by spawnRadiousSize
	var xOffset = randi_range(-spawnRadiusSize, spawnRadiusSize)
	var yOffset = randi_range(-spawnRadiusSize, spawnRadiusSize)
	enemyInstance.position = Vector2i(xOffset, yOffset)
