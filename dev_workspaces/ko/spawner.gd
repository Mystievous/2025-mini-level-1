extends Marker2D
#preloads the enemies to be able to insantiate them from the spawner
var enemySceneRed   := preload("uid://drebcau7s58qn")
var enemySceneGreen := preload("uid://dla32lb7q5d2l")
var enemySceneBlue  := preload("uid://rhi68tw21wia")

@onready var debug_visuals: Node = $DebugVisuals
@onready var debug_spawner_range_visual: Sprite2D = $DebugVisuals/SpawnerRange

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
##Sets how many times enemies will reappear after they are all defeated. Default: 3
@export var numberOfWaves: int = 3
##Sets how many enemies are in a wave. Default: 5
@export var amountOfEnemiesInWave: int = 5
##Determines whether the sprite at the spawner's position, the spawn radious and debug text is shown. Default: false
@export var showDebugVisual: bool = false

#keeps track of the current wave
var currentWave: int = 0

func _ready() -> void:
	if showDebugVisual:
		debug_visuals.show()
		debug_spawner_range_visual.apply_scale(Vector2(spawnRadiusSize,spawnRadiusSize))

#does a new wave when the wave conditions are met
func _process(_delta: float) -> void:
	waves()
	#when spacebar is pressed: deletes all enemies in the wave so the next one can appear
	if showDebugVisual:
		if Input.is_action_just_pressed("ui_accept"):
			for childrenCounter in self.get_children():
				if (childrenCounter.get_index() > 0): #skips the first node because that one is the DebugVisual
					self.get_child(childrenCounter.get_index()).queue_free()

#do the next wave if all enemies are defeated and currentWave < numberOfWaves
func waves() -> void:
		if (currentWave < numberOfWaves) and (self.get_child_count() <= 1):
			for enemiesToSpawn in amountOfEnemiesInWave:
				spawnEnemy()
			currentWave += 1
			if showDebugVisual:
				print("curent wave is ",  currentWave)
				print(self.get_children())
				print()

func spawnEnemy() -> void:
	var enemyInstance
	var spawnerTypeSelection: int
	
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

	#modifies the enemies position to a random range determined by spawnRadiusSize
	var xOffset: int = randi_range(-spawnRadiusSize, spawnRadiusSize)
	var yOffset: int = randi_range(-spawnRadiusSize, spawnRadiusSize)
	enemyInstance.position = Vector2i(xOffset, yOffset)
