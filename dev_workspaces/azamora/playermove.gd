class_name Playermove
extends CharacterBody2D

@export var speed : float = 250 #player speed
@export var animation_tree: AnimationTree

var input : Vector2
var playback : AnimationNodeStateMachinePlayback

func _ready():
	playback = animation_tree["parameters/playback"]

#directional input
func _physics_process(_delta: float) -> void:
	input = Input.get_vector("left", "right", "up", "down")
	velocity = input * speed
	move_and_slide()
	select_animation()
	update_animation_parameters()

#checks if WASD or arrow keys are being pressed on for animation
func select_animation():
	if velocity == Vector2.ZERO:
		playback.travel("Idle")
	else:
		playback.travel("Walk")

func update_animation_parameters():
	if input == Vector2.ZERO:
		return
		
	# determines what direction to face
	animation_tree["parameters/Idle/blend_position"] = input
	animation_tree["parameters/Walk/blend_position"] = input
