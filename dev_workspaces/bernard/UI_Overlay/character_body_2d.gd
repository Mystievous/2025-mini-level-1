extends CharacterBody2D

@export var speed = 300
@onready var mySprite:  AnimatedSprite2D = $Sprite2D 
var direction = Vector2.DOWN #default is down

func _physics_process(_delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
	
	if (input_direction.x != 0 or input_direction.y != 0):
		if (input_direction.x <0): # moving left
			mySprite.play("run_left")
		elif (input_direction.x > 0): # moving right
			mySprite.play("run_right")
		elif (input_direction.y < 0): # moving up/back
			mySprite.play("run_back")
		elif (input_direction.y > 0): # moving down/front
			mySprite.play("run_front")
	else:
		mySprite.play("idle_front")
		
	move_and_slide()
