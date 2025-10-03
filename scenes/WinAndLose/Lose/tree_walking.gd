extends AnimatedSprite2D

const SPEED = 50
var direction = -1
const MARGIN = 10 

# Use this function to reliably get the width of the current frame
func get_char_width():
	var frames_resource = sprite_frames
	
	if frames_resource and animation != "":
		# Get the texture of the current frame
		var current_texture = frames_resource.get_frame_texture(animation, frame)
		
		if current_texture:
			return current_texture.get_width() * scale.x
	
	return 32.0 * scale.x # Use a default value (e.g., 32 is a common sprite size)

func _ready():
	play("Tree_walk_left")
	
	# Wait until the animation has a valid texture to calculate the width
	await get_tree().process_frame
	
	var char_width = get_char_width()
	var screen_width = get_viewport_rect().size.x
	
	
	# Set the center position (position.x) so the left edge is at MARGIN
	position.x = screen_width - (char_width / 2) - MARGIN
	
	flip_h = false

func _process(delta):
	# Calculate boundaries 
	var screen_width = get_viewport_rect().size.x
	var char_width = get_char_width() # Use the new function to get width
	
	var right_edge = position.x + (char_width / 2)
	var left_edge = position.x - (char_width / 2)
	
	if direction == 1: # reverses direction
		if right_edge >= screen_width - MARGIN:
			direction = -1 
			play("Tree_walk_left") 
			
	elif direction == -1:
		if left_edge <= MARGIN:
			direction = 1 
			play("Tree_walk_right")

	position.x += SPEED * direction * delta
